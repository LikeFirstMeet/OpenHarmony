/*
 * Copyright (c) 2022-2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import mediaLibrary from '@ohos.multimedia.mediaLibrary'
import preferences from '@ohos.data.preferences'
import DateTimeUtil from '../model/DateTimeUtil'
import type common from '@ohos.app.ability.common'
import Logger from './Logger'
import { Record } from './Record'

const TAG: string = '[Recorder.MediaManager]'

class MediaManager {
  private context: common.UIAbilityContext
  private mediaTest: mediaLibrary.MediaLibrary = null
  private storage: preferences.Preferences = null

  constructor(context: common.UIAbilityContext) {
    this.context = context
    this.mediaTest = mediaLibrary.getMediaLibrary(this.context)
    this.initStorage()
  }

  async initStorage() {
    let name = 'ohos.samples.recorder'
    try {
      this.storage = await preferences.getPreferences(this.context, `${name}`)
    } catch (err) {
      Logger.error(`getStorage failed, code is ${err.code}, message is ${err.message}`)
    }
    if (this.storage === null) {
      Logger.info(TAG, `Create stroage is fail.`)
    }
  }

  async createAudioFile() {
    this.mediaTest = mediaLibrary.getMediaLibrary(this.context)
    let info = {
      suffix: '.m4a', directory: mediaLibrary.DirectoryType.DIR_AUDIO
    }
    let dateTimeUtil = new DateTimeUtil()
    let name = `${dateTimeUtil.getDate()}_${dateTimeUtil.getTime()}`
    let displayName = `${name}${info.suffix}`
    Logger.info(TAG, `createAudioFile displayName=${displayName}`)
    let publicPath = await this.mediaTest.getPublicDirectory(info.directory)
    Logger.info(TAG, `createAudioFile publicPath=${publicPath}`)
    return await this.mediaTest.createAsset(mediaLibrary.MediaType.AUDIO, displayName, publicPath)
  }

  async queryAllAudios() {
    let fileKeyObj = mediaLibrary.FileKey
    let fetchOp = {
      selections: `${fileKeyObj.MEDIA_TYPE}=?`,
      selectionArgs: [`${mediaLibrary.MediaType.AUDIO}`],
    }
    const fetchFileResult = await this.mediaTest.getFileAssets(fetchOp)
    let result: Array<Record> = []
    Logger.info(TAG, `queryAllAudios fetchFileResult=${fetchFileResult.getCount()}`)
    if (fetchFileResult.getCount() > 0) {
      let fileAssets = await fetchFileResult.getAllObject()
      for (let i = 0; i < fileAssets.length; i++) {
        let record = new Record(this.context)
        await record.init(fileAssets[i], false)
        result.push(record)
      }
    }
    return result
  }

  async queryFile(id: number) {
    let fileKeyObj = mediaLibrary.FileKey
    if (id !== undefined) {
      let args = id.toString()
      let fetchOp = {
        selections: `${fileKeyObj.ID}=?`,
        selectionArgs: [args],
      }
      const fetchFileResult = await this.mediaTest.getFileAssets(fetchOp)
      Logger.info(TAG, `fetchFileResult.getCount() = ${fetchFileResult.getCount()}`)
      const fileAsset = await fetchFileResult.getAllObject()
      let record = new Record(this.context)
      await record.init(fileAsset[0], false)
      return record
    } else {
      return undefined
    }
  }

  deleteFile(uri) {
    Logger.info(TAG, `deleteFile,uri = ${uri}`)
    return this.mediaTest.deleteAsset(uri)
  }

  onAudioChange(callback: () => void) {
    this.mediaTest.on('audioChange', () => {
      callback()
    })
  }

  async saveFileDuration(name: string, value): Promise<void> {
    if (this.storage === null) {
      Logger.info(TAG, `Create stroage is fail.`)
      return
    }
    await this.storage.put(name, value)
    await this.storage.flush()
  }

  async getFileDuration(name: string): Promise<string> {
    let bundleName = 'ohos.samples.recorder'
    let duration
    try {
      let storage = await preferences.getPreferences(this.context, `${bundleName}`)
      duration = await storage.get(name, '00:00')
    } catch (err) {
      Logger.info(TAG, `Failed to get value of duration,code:${err.code},message:${err.message}`)
    }
    return duration as string
  }
}

export default MediaManager