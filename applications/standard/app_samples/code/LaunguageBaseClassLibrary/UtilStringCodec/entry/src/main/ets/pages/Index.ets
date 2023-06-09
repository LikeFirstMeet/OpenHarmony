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

import util from '@ohos.util'
import { SpecInput } from '../common/specInput'
import { GetString } from '../utils/GetString'


@Entry
@Component
struct StrCodec {
  resArray: Uint8Array = undefined
  @State specStrInput_f: string = ''
  @State specStrInput_s: string = ''
  @State specStrInput_d: string = ''
  @State specStrInput_i: string = ''
  @State resen: string = ''
  @State resdec: string = ''
  @State read: string = ''
  @State write: string = ''
  private getString: GetString = new GetString(getContext(this))

  build() {
    Column() {
      Text($r('app.string.StringCodec_title'))
        .width('100%')
        .height(50)
        .backgroundColor($r('app.color.text_color'))
        .textAlign(TextAlign.Start)
        .fontSize(25)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .padding({ left: 20, top: 10 })
      Scroll() {
        Column() {
          Row() {
            Text($r('app.string.SpecString'))
              .fontSize(15)
              .width(60)
              .height(50)
              .margin({ top: 20 })
              .textAlign(TextAlign.Start)
            Text($r('app.string.SpecString_info'))
              .fontSize(15)
              .width(200)
              .height(50)
              .margin({ left: 5, top: 20 })
              .textAlign(TextAlign.Start)
          }

          SpecInput({ result_str: $r('app.string.result_f'), specStrInput: $specStrInput_f })
          SpecInput({ result_str: $r('app.string.result_i'), specStrInput: $specStrInput_i })
          SpecInput({ result_str: $r('app.string.result_d'), specStrInput: $specStrInput_d })
          SpecInput({ result_str: $r('app.string.result_s'), specStrInput: $specStrInput_s })
          Button() {
            Text($r('app.string.SpecFormOutput')).fontSize(15).fontWeight(FontWeight.Bold).fontColor(Color.White)
          }
          .key('specFormatOutput')
          .width(300)
          .margin({ top: 20 })
          .onClick(() => {
            this.specStrInput_f = util.format("%f", "OpenHarmony 3.0")
            this.specStrInput_i = util.format("%i", "OpenHarmony 3.0")
            this.specStrInput_d = util.format("%d", "OpenHarmony 3.0")
            this.specStrInput_s = util.format("%s", "OpenHarmony 3.0")
          })
          .backgroundColor($r('app.color.text_color'))

          Text('')
            .width('100%')
            .height(10)
            .backgroundColor($r('app.color.text_color'))
            .margin({ top: 20 })
            .border({ width: 2, color: $r('app.color.text_color') })

          Row() {
            Text($r('app.string.SpecString'))
              .fontSize(15)
              .width(60)
              .height(50)
              .margin({ top: 20 })
              .textAlign(TextAlign.Start)
            Text($r('app.string.StringCodec_info'))
              .fontSize(15)
              .width(240)
              .height(50)
              .margin({ left: 5, top: 20 })
              .textAlign(TextAlign.Start)
          }

          Row() {
            Text($r('app.string.result'))
              .width('20%')
              .height(30)
              .fontSize(15)
              .textAlign(TextAlign.Start)
            Text(this.resen)
              .width('80%')
              .height(60)
              .fontSize(15)
              .maxLines(2)
              .textAlign(TextAlign.Start)
              .border({ width: 2, radius: 5, color: $r('app.color.text_color') })
          }.margin({ top: 20 }).width(300)

          Row() {
            Text($r('app.string.read'))
              .width('20%')
              .height(30)
              .fontSize(15)
              .textAlign(TextAlign.Start)
            Text(this.read)
              .width('30%')
              .height(30)
              .fontSize(15)
              .textAlign(TextAlign.Start)
              .border({ width: 2, radius: 5, color: $r('app.color.text_color') })
            Text($r('app.string.write')).width('20%')
              .height(30)
              .fontSize(15)
              .textAlign(TextAlign.Center)
            Text(this.write)
              .width('30%')
              .height(30)
              .fontSize(15)
              .textAlign(TextAlign.Start)
              .border({ width: 2, radius: 5, color: $r('app.color.text_color') })
          }.margin({ top: 20 }).width(300)

          Button() {
            Text($r('app.string.Text_encoder'))
              .fontColor(Color.White)
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
          }
          .key('textEncoder')
          .margin({ top: 20 })
          .onClick(() => {
            let textEncoder = new util.TextEncoder()
            let buffer = new ArrayBuffer(100)
            this.resArray = new Uint8Array(buffer)
            this.resArray = textEncoder.encode(this.getString.convertResourceToString($r('app.string.message')))
            let resArratNum = textEncoder.encodeInto(this.getString.convertResourceToString($r('app.string.message')), this.resArray)
            this.resen = this.resArray.toString()
            this.read = JSON.stringify(resArratNum.read)
            this.write = JSON.stringify(resArratNum.written)
          })
          .backgroundColor($r('app.color.text_color'))
          .width(300)

          Row() {
            Text($r('app.string.result'))
              .width('20%')
              .height(30)
              .fontSize(15)
              .textAlign(TextAlign.Start)
              .fontColor(Color.Black)
            Text(this.resdec)
              .width('80%')
              .height(60)
              .fontSize(15)
              .textAlign(TextAlign.Start)
              .maxLines(2)
              .border({ width: 2, radius: 5, color: $r('app.color.text_color') })
          }.margin({ top: 20 }).width(300)

          Button() {
            Text($r('app.string.Text_decoder')).fontColor(Color.White).fontSize(15).fontWeight(FontWeight.Bold)
          }
          .key('textDecoder')
          .margin({ top: 20, bottom: 50 })
          .onClick(() => {
            let textDecoder = new util.TextDecoder("utf-8", { ignoreBOM: true })
            if (this.resArray === undefined) {
              return
            }
            let retStr = textDecoder.decode(this.resArray, { stream: false })
            this.resdec = retStr
          })
          .backgroundColor($r('app.color.text_color'))
          .width(300)
        }
      }
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }
}