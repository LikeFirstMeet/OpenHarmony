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
import prompt from '@ohos.prompt'
import { Record } from '../model/Record'

@CustomDialog
export struct RenameDialog {
  private controller: CustomDialogController
  private record: Record = null
  private newName: string = ''
  private renameCallback: (newName: string) => void

  aboutToAppear() {
    this.newName = this.record.fileAsset.title
  }

  build() {
    Column() {
      TextInput({ placeholder: 'input name', text: this.record.fileAsset.title })
        .type(InputType.Normal)
        .placeholderColor(Color.Gray)
        .maxLength(20)
        .fontSize(19)
        .onChange((value: string) => {
          this.newName = value
        })
        .key('renameInput')
      Row() {
        Button() {
          Text($r('app.string.sure'))
            .fontColor(Color.Blue)
            .fontSize(17)
        }
        .layoutWeight(7)
        .backgroundColor(Color.White)
        .margin(5)
        .onClick(() => {
          if (this.newName === '') {
            prompt.showToast({ message: 'input name' })
            return
          }
          this.controller.close()
          if (this.newName != this.record.fileAsset.title) {
            this.renameCallback(this.newName)
          }
        })

        Button() {
          Text($r('app.string.cancel'))
            .fontColor(Color.Red)
            .fontSize(17)
        }
        .layoutWeight(7)
        .backgroundColor(Color.White)
        .margin(5)
        .onClick(() => {
          this.controller.close()
        })
      }
      .width('100%')
      .margin({ top: '3%' })
    }
    .padding('3%')
  }
}