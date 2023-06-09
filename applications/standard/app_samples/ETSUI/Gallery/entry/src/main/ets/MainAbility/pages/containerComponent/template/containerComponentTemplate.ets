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


import { NavigationBar } from '../../../common/components/navigationBar'
import { GetColor } from '../../../common/components/getColor'

@Entry
@Component
struct ContainerComponentTemplate {
  @State content: string = 'hello world'
  @State backgroundColor: string = '#b6dfff'
  @State value: number = 0
  @State setValue: number = 10;
  @State fontColor: string = '#182431';
  @State setProgressColor: Color = Color.Black;

  build() {
    Column() {
      NavigationBar({ title: '容器组件模板' })

      Scroll() {
        Column() {
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
          Text('显示效果')
            .fontSize(24)
            .fontColor(this.fontColor)
        }
        .width('97%')
        .margin({ right: '3%' })
      }
      .constraintSize({ minHeight: 218, maxHeight: 402 })
      .padding({ left: 12, right: 12, top: 22, bottom: 22 })
      .width('100%')
      .height('45%')
      .backgroundColor(this.backgroundColor)

      Scroll() {
        Column() {

          Row() {
            Text('content选项')
              .fontSize('16fp')
              .fontColor('#182431')
              .opacity(0.5)
              .fontWeight(FontWeight.Medium)
            Blank()

            Text(`${this.content}`)
              .bindMenu([
                {
                  value: 'hello world',
                  action: () => {
                    this.content = "hello world"
                  }
                },
                {
                  value: 'just do it',
                  action: () => {
                    this.content = "just do it"
                  }
                },
                {
                  value: 'to be No.1',
                  action: () => {
                    this.content = "to be No.1"
                  }
                },
              ])
              .fontSize('16fp')
              .fontColor('#182431')
              .fontWeight(FontWeight.Medium)
              .width('50%')
              .textAlign(TextAlign.End)


          }
          .width('100%')
          .padding('3%')
          .borderRadius(24)
          .backgroundColor('#FFFFFF')

          Row() {
            Text('true或者false样式')
              .fontSize('16fp')
              .fontColor('#182431')
              .opacity(0.5)
              .fontWeight(FontWeight.Medium)
            Blank()
            Toggle({ type: ToggleType.Switch, isOn: false })
              .selectedColor('#007DFF')
              .switchPointColor(0xe5ffffff)
              .onChange((isOn: boolean) => {
                console.info('Component status:' + isOn)
              })
          }
          .width('100%')
          .borderRadius(24)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          Row() {
            Text('数字选项样式')
              .fontSize('16fp')
              .fontColor('#182431')
              .opacity(0.5)
              .fontWeight(FontWeight.Medium)
            Blank()
              Counter() {
                Text(this.value.toString())
              }
              .onInc(() => {
                this.value++
              })
              .onDec(() => {
                this.value--
              })
          }
          .width('100%')
          .padding('3%')
          .borderRadius(24)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          Row() {
            Button('Ok', { type: ButtonType.Capsule, stateEffect: true }).backgroundColor(0x317aff).width(90)
              .onClick((event: ClickEvent) => {
                console.info('点击按钮1')
              })
            Blank()
            Button('Ok', { type: ButtonType.Capsule, stateEffect: true }).backgroundColor(0x317aff).width(90)
              .onClick((event: ClickEvent) => {
                console.info('点击按钮2')
              })
          }
          .width('100%')
          .padding('3%')
          .borderRadius(24)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          Column() {
            Row() {
              Text('progress value')
                .fontSize('16fp')
                .fontColor('#182431')
                .opacity(0.5)
                .fontWeight(FontWeight.Medium)
              Blank()
              Text(this.setValue.toFixed(0))
                .fontSize('16fp')
                .fontColor('#182431')
                .fontWeight(FontWeight.Medium)
            }
            .width('100%')

            Slider({
              value: this.setValue,
              min: 0,
              max: 100,
              step: 1,
              style: SliderStyle.OutSet
            })
              .blockColor('#FFFFFF')
              .trackColor('#183431')
              .selectedColor('#007DFF')
              .borderRadius(12)
              .borderColor('rgba(0,0,0,0.04)')
              .showTips(true)
              .showSteps(true)
              .onChange((value: number, mode: SliderChangeMode) => {
                this.setValue = value
                console.info('value:' + value + 'mode:' + mode.toString())
              })
          }
          .padding('3%')
          .borderRadius(24)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          Row() {
            Text('backgroundColor')
              .fontSize('16fp')
              .fontColor('#182431')
              .opacity(0.5)
              .fontWeight(FontWeight.Medium)
            Blank()
            Column(){
              GetColor({ colorVal: $backgroundColor })
            }
            .width(48)
          }
          .width('100%')
          .padding('3%')
          .borderRadius(24)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

          Row() {
            Text('fontColor')
              .fontSize('16fp')
              .fontColor('#182431')
              .opacity(0.5)
              .fontWeight(FontWeight.Medium)
            Blank()
            Column() {
              GetColor({ colorVal: $fontColor })
            }
            .width(48)
          }
          .width('100%')
          .padding('3%')
          .borderRadius(24)
          .backgroundColor('#FFFFFF')
          .margin({ top: 8 })

        }
      }
      .height('45%')
      .margin({ top: 24 })
    }
    .height('100%')
    .padding({ left: '3%', right: '3%', bottom: 10 })
    .backgroundColor('#F1F3F5')
  }

  pageTransition() {
    PageTransitionEnter({ duration: 370, curve: Curve.Friction })
      .slide(SlideEffect.Bottom)
      .opacity(0.0)

    PageTransitionExit({ duration: 370, curve: Curve.Friction })
      .slide(SlideEffect.Bottom)
      .opacity(0.0)
  }
}
