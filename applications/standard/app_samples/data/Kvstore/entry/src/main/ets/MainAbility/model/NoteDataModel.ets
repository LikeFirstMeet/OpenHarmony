/*
 * Copyright (c) 2020 Huawei Device Co., Ltd.
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
import Logger from '../util/Logger'
export class NoteModel {
  title: string
  content: string

  constructor(title: string, content: string) {
    this.title = title
    this.content = content
  }
}

export function transStrToNoteModel(str: string): Array<NoteModel> {
  let noteList: Array<NoteModel> = []
  var notes = JSON.parse(str)
  Logger.info('[NoteModel]notes.length = ' + notes.length)
  for (var note in notes) {
    noteList.push({ title: notes[note].title, content: notes[note].content })
  }
  return noteList
}