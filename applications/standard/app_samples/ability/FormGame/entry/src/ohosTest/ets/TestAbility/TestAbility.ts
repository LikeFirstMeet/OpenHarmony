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

import hilog from '@ohos.hilog';
import Ability from '@ohos.application.Ability'
import AbilityDelegatorRegistry from '@ohos.application.abilityDelegatorRegistry'
import { Hypium } from '@ohos/hypium'
import testsuite from '../test/List.test'

export default class TestAbility extends Ability {
  onCreate(want, launchParam) {
    hilog.info(0x0000, "FormGame", "%{public}s", 'TestAbility onCreate')
  }

  onDestroy() {
    hilog.info(0x0000, "FormGame", "%{public}s", 'TestAbility onDestroy')
  }

  onWindowStageCreate(windowStage) {
    hilog.info(0x0000, "FormGame", "%{public}s", 'TestAbility onWindowStageCreate')
    windowStage.loadContent("TestAbility/pages/index", (err, data) => {
      if (err.code) {
        hilog.error(0x0000, "FormGame", "%{public}s", 'Failed to load the content. Cause:' + JSON.stringify(err));
        return;
      }
      hilog.info(0x0000, "FormGame", "%{public}s", 'Succeeded in loading the content. Data: ' + JSON.stringify(data))
    });

    var abilityDelegator: any
    abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator()
    var abilityDelegatorArguments: any
    abilityDelegatorArguments = AbilityDelegatorRegistry.getArguments()
    hilog.info(0x0000, "FormGame", "%{public}s", 'start run testcase!!!')
    Hypium.hypiumTest(abilityDelegator, abilityDelegatorArguments, testsuite)
  }

  onWindowStageDestroy() {
    hilog.info(0x0000, "FormGame", "%{public}s", 'TestAbility onWindowStageDestroy')
  }

  onForeground() {
    hilog.info(0x0000, "FormGame", "%{public}s", 'TestAbility onForeground')
  }

  onBackground() {
    hilog.info(0x0000, "FormGame", "%{public}s", 'TestAbility onBackground')
  }
};
