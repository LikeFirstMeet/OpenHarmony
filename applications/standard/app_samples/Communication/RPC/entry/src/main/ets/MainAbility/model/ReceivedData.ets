/*
 * Copyright (c) 2021 Huawei Device Co., Ltd.
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

import rpc from "@ohos.rpc"
import { Logger } from '../common/Logger'

let TAG = '[eTSRPC.ReceivedData]'
let resultList: Array<number> = Array.from({ length: 4 }, () => 0)
let priceList: Map<string, number> = new Map([
  ['potato', 4],
  ['cabbage', 2],
  ['eggplant', 6],
  ['apple', 8],
  ['banana', 6],
  ['peach', 12],
  ['beef', 25],
  ['chicken', 8],
  ['pork', 12],
  ['biscuits', 15],
  ['candy', 20],
  ['chips', 12]
])

class ReceivedData extends rpc.RemoteObject {
  onRemoteRequest(code: number, data: any, reply: any, option: any) {
    console.log(`${TAG} called`)
    if (code === 1) {
      let result = 0
      let readIntArr
      try {
        readIntArr = data.readStringArray()
      } catch (err) {
        Logger.error(`readStringArray failed, code is ${err.code}, message is ${err.message}`)
      }
      console.log(`${TAG} readIntArr= ${readIntArr}`)
      for (let i = 0; i < 4; i++) {
        if (readIntArr[i] === '0') {
          resultList[i] = 0
        } else {
          resultList[i] = priceList.get(readIntArr[i]) * Number(readIntArr[i+4])
        }
        console.log(`${TAG}, this.resultList= ${resultList}`)
        result += resultList[i]
      }
      try {
        reply.writeInt(result)
      } catch (err) {
        Logger.error(`writeInt failed, code is ${err.code}, message is ${err.message}`)
      }
      console.log(`${TAG} result= ${result}`)
    } else {
      console.log(`${TAG} unknown request code`)
    }
    return true
  }
}

export default new ReceivedData("send")