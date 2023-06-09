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

import xml from '@ohos.xml'
import Logger from '../model/Logger'
import ConvertXML from '@ohos.convertxml'

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
      listener.onDataAdded(index)
    })
  }

  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChanged(index)
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

const TAG: string = '[SelectOption]'

@Component
export struct SelectOption {
  private options: Resource[] = [$r('app.string.serializer'), $r('app.string.parser'), $r('app.string.convert')]
  @Link outputs: string
  @Link inputs: string

  serializerNode() {
    let arrayBuffer = new ArrayBuffer(1024)
    let serializer = new xml.XmlSerializer(arrayBuffer)
    serializer.setDeclaration()
    serializer.setNamespace('h', 'https://gitee.com/openharmony')
    serializer.startElement('note')
    serializer.setAttributes('importance', 'high')
    serializer.addEmptyElement('b')
    serializer.setComment('contact information')
    serializer.setText('ZhangSan 18712345678')
    serializer.setCDATA('CData')
    serializer.setDocType('DocType')
    serializer.endElement()
    let array = new Uint8Array(arrayBuffer)
    let serializerStr = ''
    for (let i = 0; i < array.length; ++i) {
      serializerStr = serializerStr + String.fromCodePoint(array[i])
    }
    this.outputs = serializerStr
  }

  parserNode() {
    let arrayBuffer = new ArrayBuffer(this.inputs.length * 2)
    let bufView = new Uint8Array(arrayBuffer)
    let strLen = this.inputs.length
    for (let k = 0; k < strLen; ++k) {
      bufView[k] = this.inputs.charCodeAt(k)
    }
    let parser = new xml.XmlPullParser(arrayBuffer)
    let arr = {}
    let i = 0

    function func(key, info) {
      arr[i] = `key:${key}, value:${info.getDepth()} ${info.getColumnNumber()} ` +
      `${info.getLineNumber()} ${info.getAttributeCount()} ${info.getName()} ` +
      `${info.getText()} ${info.isEmptyElementTag()} ${info.isWhitespace()}\n`
      i++
      return true
    }

    let options = { supportDoctype: true, ignoreNameSpace: true, tokenValueCallbackFunction: func }
    parser.parse(options)
    let str = ''
    for (let j = 0; j < i; ++j) {
      str = str + arr[j]
    }
    this.outputs = str
  }

  convertNode() {
    Logger.info(`${TAG}, convertNode start`)
    let options = {
      trim: false,
      declarationKey: "_declaration",
      instructionKey: "_instruction",
      attributesKey: "_attributes",
      textKey: "_text",
      cdataKey: "_cdata",
      doctypeKey: "_doctype",
      commentKey: "_comment",
      parentKey: "_parent",
      typeKey: "_type",
      nameKey: "_name",
      elementsKey: "_elements"
    }
    let conv = new ConvertXML.ConvertXML()
    Logger.info(`${TAG}, convertNode new ConvertXML`)
    let result = JSON.stringify(conv.convert(this.inputs, options))
    Logger.info(`${TAG}, convertNode conv.convert result = ${result}`)
    this.outputs = JSON.stringify(result)
    Logger.info(`${TAG}, convertNode end`)
  }

  build() {
    Column() {
      Column() {
        LazyForEach(new MyDataSource(this.options), item => {
          Button() {
            Text(item)
              .fontSize(20)
              .textAlign(TextAlign.Center)
              .fontColor(Color.White)
              .width('70%')
          }
          .type(ButtonType.Capsule)
          .backgroundColor('#0D9FFB')
          .padding(5)
          .margin({ top: 10 })
          .onClick(() => {
            let index = this.options.indexOf(item)
            switch (index) {
              case 0:
                this.serializerNode()
                break
              case 1:
                this.parserNode()
                break
              case 2:
                this.convertNode()
                break
              default:
                break
            }
          })
        }, item => JSON.stringify(item))
      }.width('100%')
    }.width('100%')
  }
}