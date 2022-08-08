### 利用computed设置全选功能
```js
<!DOCTYPE html>

<html lang="en">

  <head>

    <meta charset="UTF-8" />

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Document</title>

    <style>

      .done {

        color: gray;

        text-decoration: line-through;

      }

    </style>

  </head>

  <body>

    <div id="app">

      <ul>

        全选<input type="checkbox" v-model="allDone" />

        <li v-for="todo in todos">

          <input type="checkbox" v-model="todo.done" />

          <span :class="{done:todo.done}"> {{todo.title}}</span>

        </li>

      </ul>

      <div>{{active}} / {{all}}</div>

    </div>

    <script src="https://unpkg.com/vue@next"></script>

  

    <script>

        const App = {

          data() {

            return {

              title: "", // 定义一个数据

              todos: [

                { title: "吃饭", done: false },

                { title: "打游戏", done: false },

                { title: "睡觉", done: true },

              ],

            };

          },

          methods: {

            addTodo() {

              this.todos.push({

                title: this.title,

                done: false,

              });

              this.title = "";

            },

          },

          computed: {

            active() {

              return this.todos.filter((v) => !v.done).length;

            },

            all() {

              return this.todos.length;

            },

            allDone: {

                get: function () {

                console.log(this.active)

                  return this.active === 0

                },

  

                set: function (val) {

                  console.log(val);

                  this.todos.forEach(todo=>{

                    todo.done = val

                  })

                }

  

            }

          }

      }

        Vue.createApp(App).mount("#app");

    </script>

  </body>

</html>