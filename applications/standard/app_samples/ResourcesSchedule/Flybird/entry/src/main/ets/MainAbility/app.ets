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

import backgroundTaskManager from '@ohos.backgroundTaskManager';
import logger from './utils/logger'

const TAG = "flybirdDebug"

export default {
  onCreate() {
    logger.info(TAG + ' Application onCreate')
  },
  onDestroy() {
    logger.info(TAG + ' Application onDestroy')
  },
  onInactive() {
    logger.info(TAG + ' Application onInactive')
    let myReason = 'test requestSuspendDelay';
    let delayInfo = backgroundTaskManager.requestSuspendDelay(myReason, () => {
      console.info(TAG + " Request suspension delay will time out.");
    });
    if (delayInfo && delayInfo.requestId) {
      logger.info(TAG + " delayInfo: " + delayInfo.requestId);
    }
  }
}