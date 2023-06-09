/*
 * Copyright (c) 2021-2023 Huawei Device Co., Ltd.
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

import power from '@ohos.power'

class BasicDataSource implements IDataSource {
  private listeners: DataChangeListener[] = []

  public totalCount(): number {
    return 0
  }

  public getData(index: number): any {
    return undefined
  }

  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener);
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }

  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded()
    })
  }

  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index)
    })
  }
}

class MyDataSource extends BasicDataSource {
  public dataArray: string[] = []

  constructor(ele) {
    super()
    for (var index = 0;index < ele.length; index++) {
      this.dataArray.push(ele[index])
    }
  }

  public totalCount(): number {
    return this.dataArray.length
  }

  public getData(index: number): any {
    return this.dataArray[index]
  }

  public addData(index: number, data: string): void {
    this.dataArray.splice(index, 0)
    this.notifyDataAdd(index)
  }
}

@Entry
@Component
struct Index {
  @State window: string = ''
  private num: number = 0
  private buttonText: MyDataSource = new MyDataSource([$r('app.string.turnOff'), $r('app.string.restart'), $r('app.string.checkState')])

  dialog(title: Resource, message: Resource) {
    AlertDialog.show(
      {
        title: title,
        message: message,
        primaryButton: {
          value: $r('app.string.cancel'),
          action: () => {
            console.info(`Callback when the first button is clicked`)
          }
        },
        secondaryButton: {
          value: $r('app.string.determine'),
          action: () => {
            console.info(`Callback when the second button is clicked`)
            if (title.id === $r('app.string.turnOff').id) {
              this.window = 'Is power off'
              power.shutdown('shutdown_test')
              console.info(`power_shutdown_device_test success`)
            } else if (title.id === $r('app.string.restart').id) {
              this.window = 'Is to restart'
              power.reboot('reboot_test')
              console.info(`power_reboot_device_test success`)
            }
          }
        },
        cancel: () => {
          console.info(`Closed callbacks`)
        }
      }
    )
  }

  checkState() {
    power.isScreenOn((error, screenOn) => {
      if (typeof error === 'undefined') {
        this.window = 'screenOn status is' + screenOn
        console.log(this.window)
      } else {
        console.log(`error: ${error}`)
      }
    })
  }

  build() {
    Column() {
      Row() {
        Text($r('app.string.MainAbility_label'))
          .fontColor(Color.White)
          .fontSize(20)
      }
      .size({ width: '100%', height: 50 })
      .padding({ left: 15 })
      .backgroundColor('#0D9FFB')

      Text(this.window)
        .width('90%')
        .height(100)
        .border({ width: 2, radius: 10, color: Color.Black })
        .margin({ top: 20 })
        .padding({ left: 10 })
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      LazyForEach(this.buttonText, (item, index) => {
        Button() {
          Text(item)
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
        }
        .width('80%')
        .margin({ top: '20' })
        .type(ButtonType.Capsule)
        .backgroundColor('#0D9FFB')
        .onClick(() => {
          switch (index) {
            case 0:
              this.dialog($r('app.string.turnOff'), $r('app.string.questionTurnOff'))
              break
            case 1:
              this.dialog($r('app.string.restart'), $r('app.string.questionRestart'))
              break
            case 2:
              this.checkState()
              break
            default:
              break
          }
        })
      }, item => JSON.stringify(item))
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height('100%')
  }
}
