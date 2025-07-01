建议静态文件导入

#### 在终端初始化vue项目

```html
<!-- 项目文件夹目录下 -->
npm init vue@latest
<!-- 等待创建完成后 -->
cd 创建的项目文件夹
npm install
npm run dev
```

#### 或者使用create命令创建项目

```html
vue create projectName
<!-- 等待创建完成 --> 
npm run serve
```

#### 打包vue项目

```html
npm run build
```

### 语法

创建Vue实例

```vue
<div id = "changeText">{{ message }}</div>
<script>
    const change = {
        data(){	//设置data数据
            return {
                message: "changeText"
            }
        }
    }
	Vue.createApp(change).mount('#changeText')	//mount('#元素Id')
</script>
```

方法以及方法使用

```html
<div id = "changeText">{{ message }}</div>
<script>
    const change = {
        data(){
            return {message: "changeText"}
        },
        //定义方法
        method:{
        	increment() {
                //this指该组件实例
                this.message: "changeAgain"
    		}
	    }
    }
	Vue.createApp(change).mount('#changeText')
    //调用方法可以直接调用
    //Vue.createApp(change).mount('#changeText').increment()
    //或者
    const element = Vue.createApp(change).mount('#changeText')	
    element.increment()
</script>
```

vue使用双大括号表示文本插值

```html
<div>{{message}}</div>  <!-- 插值 -->
```

指令

```html
<!-- 指令是带有前缀 v- 的特殊属性，用于在模板中表达逻辑 -->
<!-- v-bind动态绑定一个或多个特性，或一个组件prop -->
<a v-bind:href="url">Link</a> <!-- 简写 :href="url" -->
<!-- v-if 条件渲染-->
<p v-if="seen">Now you see me</p>
<!-- v-for 列表渲染 -->
<ul><li v-for="item in items" :key="item.id">{{ item.text }}</li></ul>
<!-- v-model 双向数据绑定。-->
<input v-model="message" placeholder="edit me">
<p>Message is: {{ message }}</p>
<!-- v-on 事件监听器。 -->
<button v-on:click="doSomething">Click me</button> <!-- 简写@click="doSomething" -->
```



## 组合式API

## setup()

在setup下，ref返回值会自动浅层解包，自动使用.value，使用this亦是同样的效果

```vue
<script >
    export default{
         setup(){
            const value = ref(0)
            return {count}
        },
        method({
            function getValue(){
            	return value;
        	}
        })   
    }
</script>

```







