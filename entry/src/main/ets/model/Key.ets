
@ObservedV2
export class BooleanKey{
  @Trace key: boolean
  constructor(key: boolean) {
    this.key = key
  }
}

@ObservedV2
export class NumberKey{
  @Trace key: number

  constructor(key:number) {
    this.key = key
  }
}

@ObservedV2
export class StringKey{
  @Trace key: string

  constructor(key:string) {
    this.key = key
  }
}


@ObservedV2
export class ResourceStrKey{
  @Trace key: ResourceStr

  constructor(key:ResourceStr) {
    this.key = key
  }
}