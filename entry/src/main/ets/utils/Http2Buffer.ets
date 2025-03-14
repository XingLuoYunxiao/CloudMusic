import { Context } from '@kit.AbilityKit';
import { http } from '@kit.NetworkKit';
import fileIo from '@ohos.file.fs';

interface resultClass {
  fileName: string
  // 必须叫formImages不然卡片收不到
  formImages: Record<string, number>
}


export class Http2BufferClass {
  static httpFile: string = ''
  static result: resultClass = {
    fileName: '',
    formImages: {}
  }

  static async get(httpFile: string, context: Context, callback: (result: resultClass) => void) {
    // 如果下载的地址一样，直接返回
    if (httpFile === Http2BufferClass.httpFile) {
      callback(Http2BufferClass.result)
    } else {
      let tempDir = context.getApplicationContext().tempDir;
      let fileName = 'file' + Date.now()
      let tmpFile = tempDir + '/' + fileName;
      let httpRequest = http.createHttp()
      let data = await httpRequest.request(httpFile);
      if (data?.responseCode == http.ResponseCode.OK) {
        let imgFile = fileIo.openSync(tmpFile, fileIo.OpenMode.READ_WRITE | fileIo.OpenMode.CREATE);
        Http2BufferClass.result = {
          // 名字必须是下载的路径
          fileName: tmpFile,
          formImages: {
          }
        }
        Http2BufferClass.result.formImages[tmpFile] = imgFile.fd;
        try {
          let writeLen: number = await fileIo.write(imgFile.fd, data.result as ArrayBuffer);
          console.info("write data to file succeed and size is:" + writeLen);
          console.info('ArkTSCard download complete: %{public}s', tmpFile);
          Http2BufferClass.httpFile = httpFile;
          callback(Http2BufferClass.result)
        } finally {
          // 在fileIo.closeSync执行之前，确保formProvider.updateForm已执行完毕。
          fileIo.closeSync(imgFile);
        }
        ;
      }
      httpRequest.destroy();
    }
  }
}

