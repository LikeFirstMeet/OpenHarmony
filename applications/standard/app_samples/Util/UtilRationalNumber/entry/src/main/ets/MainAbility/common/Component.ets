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

@Component
export struct Texts {
  private Numerator: string
  private Denominator: string

  build() {
    Row() {
      Text($r('app.string.numerator'))
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Text(this.Numerator)
        .border({ width: 1, color: '#000000', radius: 10, style: BorderStyle.Solid })
        .width('80')
        .fontSize(30)
        .textAlign(TextAlign.Center)
      Text($r('app.string.denominator'))
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Text(this.Denominator)
        .border({ width: 1, color: '#000000', radius: 10, style: BorderStyle.Solid })
        .width('80')
        .fontSize(30)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.SpaceAround)
  }
}


