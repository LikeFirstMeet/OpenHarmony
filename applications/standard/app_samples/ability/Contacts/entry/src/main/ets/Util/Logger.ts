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

/**
 * 日志类，主要承担如下职责
 * 1. 打印日志
 */
class Logger {
    private prefix: string
    constructor (prefix: string) {
        this.prefix = prefix
    }
    debug(...args: any[]) {
        console.debug(`[${this.prefix}] ${args.join('')}`)
    }
    info(...args: any[]) {
        console.info(`[${this.prefix}] ${args.join('')}`)
    }
    error(...args: any[]) {
        console.error(`[${this.prefix}] ${args.join('')}`)
    }
}

export default new Logger('Contact')