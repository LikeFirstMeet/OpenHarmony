/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
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
import router from '@ohos.router'
import Logger from '../model/Logger'
import MediaUtils from '../model/MediaUtils'
import MediaDataSource from '../view/BasicDataSource'
import { MediaItem } from '../view/MediaItem'
import { RenameDialog } from '../view/RenameDialog'
import TitleBar from '../view/TitleBar'

@Entry
@Component
struct AlbumPage {
  private tag: string = 'AlbumPage'
  private albumName: string = <string> router.getParams()['albumName']
  private mediaType: number = <number> router.getParams()['mediaType']
  private mediaUtils: MediaUtils = MediaUtils.getInstance(getContext(this))
  private renameDialogController: CustomDialogController = null
  //  @State mediaList: Array<mediaLibrary.FileAsset> = []
  private mediaDataSource: MediaDataSource = new MediaDataSource()
  @State selectMedia: mediaLibrary.FileAsset = undefined

  btnAction(operate, index) {
    Logger.info(this.tag, `btnAction callback,operate: ${operate}, index: ${index}`)
    this.selectMedia = this.mediaDataSource['dataArray'][index]
    if (operate === 'delete') {
      this.deleteMedia(() => {
        let deleteResult = this.mediaUtils.deleteFile(this.selectMedia)
        deleteResult.then(() => {
          Logger.info(this.tag, 'deleteFile callback')
          this.mediaDataSource['dataArray'].splice(index, 1)
          this.mediaDataSource.notifyDataReload()
        }).catch(err => {
          Logger.error(this.tag, `deleteFile err,err: ${err}`)
        })
      })
    } else {
      if (this.renameDialogController === null) {
        this.renameDialogController = new CustomDialogController({
          builder: RenameDialog({ title: this.selectMedia.title, action: this.renameMedia.bind(this) }),
          autoCancel: true
        })
      }
      this.renameDialogController.open()
    }
  }

  renameMedia(title) {
    Logger.info(this.tag, `renameMedia newName = ${this.selectMedia.displayName}`)
    this.selectMedia.title = title
    this.selectMedia.commitModify(err => {
      if (err !== undefined) {
        Logger.info(this.tag, `commitModify,err: ${err}`)
        return
      }
      Logger.info(this.tag, 'commitModify success')
      this.renameDialogController.close()
      this.refreshData()
    })
  }

  deleteMedia(deleteAction) {
    AlertDialog.show(
      {
        message: $r('app.string.delete_file'),
        primaryButton: {
          value: $r('app.string.yes'),
          fontColor: Color.Red,
          action: () => {
            deleteAction()
          }
        },
        secondaryButton: {
          value: $r('app.string.cancel'),
          fontColor: Color.Blue,
          action: () => {
          }
        }
      }
    )
  }

  refreshData() {
    let fileAsset = this.mediaUtils.getFileAssetsFromType(this.mediaType)
    fileAsset.then(fileList => {
      Logger.info(this.tag, 'getFileList callback')
      this.mediaDataSource['dataArray'] = fileList
      this.mediaDataSource.notifyDataReload()
    }).catch(err => {
      Logger.error(this.tag, `getFileList err,err = ${err}`)
    })
  }

  aboutToAppear() {
    Logger.info(this.tag, `mediaType=${this.mediaType}`)
    this.refreshData()
  }

  build() {
    Column() {
      TitleBar({ title: this.albumName })
      List() {
        LazyForEach(this.mediaDataSource, (item, index) => {
          ListItem() {
            MediaItem({ media: item, index: index, btnAction: this.btnAction.bind(this) })
          }.key('ListItem' + (index + 1))
          .onClick(() => {
            if (item.mediaType === mediaLibrary.MediaType.VIDEO) {
              Logger.info(this.tag, `onClick,item.id=${item.id}`)
              let context = getContext(this) as any
              context.startAbility({
                bundleName: 'ohos.samples.videoplayer',
                abilityName: 'PlayAbility',
                deviceId: "",
                parameters: {
                  fileId: item.id
                }
              }, (error) => {
                Logger.info(this.tag, `error.code = ${error.code}`)
              }
              )
            }
          })
        }, item => item.title)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
}