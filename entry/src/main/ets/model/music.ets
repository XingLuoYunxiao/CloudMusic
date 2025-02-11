import { songItemType } from "."

export interface recommendListType {
  img: string
  title: string
  count: string

}
export interface  recommendDailyType{
  img: string
  title: string
  type: string
  top: string
  bottom: string


}
export interface  favoriteListType{
  name: string
  nickName: string
  avatar: ResourceStr
  songs: songItemType[]

}
export interface  momentListType{
  author: string
  avatar: string
  content: string
  comment: number
  like: number
  song: songItemType
}
