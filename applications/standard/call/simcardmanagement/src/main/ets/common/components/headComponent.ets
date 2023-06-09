/**
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

/**
 * head custom component
 */
@Component
export default struct HeadComponent {
  @State isTouch: boolean = false;
  @State headName: any = '';

  build() {
    Row() {
      Stack({ alignContent: Alignment.Center }) {
        Image($r('app.media.back'))
          .width(24)
          .height(24)
          .fillColor($r("sys.color.ohos_id_color_primary"))
      }
      .margin({ right: 16 })
      .backgroundColor(this.isTouch ? $r('app.color.color_E3E3E3_grey') : $r('app.color.color_00000000_transparent'))
      .onClick(() => {
        globalThis.simCardAbilityContext?.terminateSelf().then((data) => {
        });
      })
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down) {
          this.isTouch = true;
        }
        if (event.type === TouchType.Up) {
          this.isTouch = false;
        }
      });

      Text(this.headName)
        .fontSize(20)
        .lineHeight(33)
        .fontFamily('HarmonyHeiTi-Bold')
        .fontWeight(FontWeight.Medium)
        .fontColor($r('app.color.font_color_182431'))
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .textAlign(TextAlign.Start)
        .margin({ top: 13, bottom: 15 });
    }
    .width("100%")
    .padding({ left: 12 })
    .height(56)
    .alignItems(VerticalAlign.Center)
    .align(Alignment.Start)
  }
}