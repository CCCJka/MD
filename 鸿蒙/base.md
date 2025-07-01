### UIAbility组件启动模式

+ Singleton单例启动

```
默认为该启动模式，每次调用startAbility()时，判断该单例是否存在，存在则复用
```

+ Standard标准实例

```
每次调用startAbility()时，都会创建一个新的实例，可以在任务列表看见多个该实例
```

+ Specified指定实例

```
创建该实例时可以指定一个Key，在
```



布局方式

+ **Column垂直方向**
  + **alignItems**：设置子组件在水平方向上的布局方式， HorizontalAlign 定义了以下三种对其方式：
    + **Start**：设置子组件在水平方向上按照语言方向起始端对齐。
    + **Center**（默认值）：设置子组件在水平方向上居左对齐。
    + **End**：设置子组件在水平方向上按照语言方向末端对齐。
  + **justifyContent**：设置子组件在竖直方向上的对齐方式， `FlexAlign` 定义了一下几种类型：
    + **Start**：元素在主轴方向首端对齐, 第一个元素与行首对齐，同时后续的元素与前一个对齐。
    + **Center**：元素在主轴方向中心对齐，第一个元素与行首的距离与最后一个元素与行尾距离相同。
    + **End**：元素在主轴方向尾部对齐, 最后一个元素与行尾对齐，其他元素与后一个对齐。
    + **SpaceBetween**：元素在主轴方向均匀分配弹性元素，相邻元素之间距离相同。 第一个元素与行首对齐，最后一个元素与行尾对齐。
    + **SpaceAround**：元素在主轴方向均匀分配弹性元素，相邻元素之间距离相同。 第一个元素到行首的距离和最后一个元素到行尾的距离时相邻元素之间距离的一半。
    + **SpaceEvenly**：元素在主轴方向元素等间距布局， 相邻元素之间的间距、第一个元素与行首的间距、最后一个元素到行尾的间距都完全一样。

+ Row水平方向

```

```

+ Flex容器中可以通过direction参数设置主轴的方向，设置为Column时，主轴的方向是垂直方向。设置为Row时，主轴的方向是水平方向

```

```


+ Stack容器中没有明确主轴与交叉轴，通过设置alignContent参数来改变容器内组件的对齐方式

```
```




跳转页面有两种方式，一种为route.pushUrl，另一种为

```

```



### 网络请求

```
import { http } from '@kit.NetworkKit';	//导入库
class test{
	let httpClient = http.createHttp()
}
```



JSON

```
将获取到的JSON字符串转化为对象
let result: HeartBeatResp = JSON.parse(response.result as string)	//第一种写法
let result = JSON.parse(response.result as string) as HeartBeatResp	//第二种写法
```

