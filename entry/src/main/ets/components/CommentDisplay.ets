import { PersistenceV2 } from '@kit.ArkUI'
import { SONG_KEY } from '../constants/EventConstants'
import { PlayStateType } from '../model/playState'

@ComponentV2
export default struct CommentDisplay {
  @Local private currentCommentIndex: number = 0
  @Local private showComment: boolean = true
  @Local private currentComment: string = ''

  @Local playState: PlayStateType = PersistenceV2.connect(PlayStateType, SONG_KEY, () => new PlayStateType())!

  private commentChangeInterval: number = 3000 // 3 seconds per comment
  private timer: number = -1

  aboutToAppear() {
    if (this.playState.playList[this.playState.playIndex].commentList.length > 0) {
      this.currentComment = this.playState.playList[this.playState.playIndex].commentList[0]
      this.startCommentRotation()
    }
  }

  aboutToDisappear() {
    if (this.timer !== -1) {
      clearInterval(this.timer)
    }
  }

  private startCommentRotation() {
    this.timer = setInterval(() => {
      this.showComment = false

      // Wait for fade out animation
      setTimeout(() => {
        this.currentCommentIndex = (this.currentCommentIndex + 1) % this.playState.playList[this.playState.playIndex].commentList.length
        this.currentComment = this.playState.playList[this.playState.playIndex].commentList[this.currentCommentIndex]
        this.showComment = true
      }, 500)
    }, this.commentChangeInterval)
  }

  build() {
    Column() {
      if (this.playState.playList[this.playState.playIndex] && this.playState.playList[this.playState.playIndex].commentList.length > 0) {
        Text(this.currentComment)
          .fontSize(12)
          .fontColor(Color.White)
          //.backgroundColor("#4D000000")
          .padding(8)
          .borderRadius(16)
          .opacity(this.showComment ? 1 : 0)
          .animation({
            duration: 500,
            curve: Curve.EaseInOut
          })
      }
    }
    .backgroundColor("#4D000000")
    .justifyContent(FlexAlign.End)
  }
}