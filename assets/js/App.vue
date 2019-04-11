<template>
  <div id="app">
    <h1>URL Shorten</h1>
    <form class="form-wrapper cf">
      <input type="text"  name="user_url" id="user_url" v-model="user_url" placeholder="Enter URL" required>
      <button type="button" v-on:click="shorten">Shorten</button>
    </form>
    <div v-if="user_error.length > 0">{{user_error}}</div>
    <div v-if="shortened.length > 0" id="outputs">
      <div v-for="item in shortened" :key="item.new">
        <h3>{{item.old}}</h3>
        <h4 :title="item.old" :id="item.new"><a :href="item.new" target="_blank">{{item.new}}</a></h4>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import clipboard from 'clipboard'

export default {
  name: 'app',
  components: {
  },
  data () {
    return {
      user_url: "",
      user_error: "",
      shortened: [
        {new: "http://localhost:4000/ii8y-KLg", old: "https://bbc.co.uk"},
        {new: "http://localhost:4000/ii8y-KLg", old: "https://bbc.co.uk"}
      ]
    }
  },
  methods: {
    shorten () {
      axios.post('/api', {
        "url": this.user_url
      })
      .then((response) => {
        if(!response.data.error) {
          this.user_error = ""
          this.user_url = ""
          this.shortened.push({new: response.data.data.hash, old: response.data.data.url})
        } else {
          this.user_error = response.data.error
        }
      })
      .catch((error) => {
        this.user_error = "Something went wrong"
      })
    }
  }
}
</script>

<style scoped>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#main-container {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  display: flex;
  overflow: hidden;
}

.cf:before, .cf:after{
    content:"";
    display:table;
}

.cf:after{
    clear:both;
}

.cf{
    zoom:1;
}
/* Form wrapper styling */
.form-wrapper {
    width: 500px;
    padding: 15px;
    margin: 50px auto 10px auto;
    background: #444;
    background: rgba(0,0,0,.2);
    border-radius: 10px;
    box-shadow: 0 1px 1px rgba(0,0,0,.4) inset, 0 1px 0 rgba(255,255,255,.2);
}

/* Form text input */

.form-wrapper input {
    width: 380px;
    height: 20px;
    padding: 10px 5px;
    float: left;
    font: bold 15px;
    border: 0;
    background: #eee;
    border-radius: 3px 0 0 3px;
}

.form-wrapper input:focus {
    outline: 0;
    background: #fff;
    box-shadow: 0 0 2px rgba(0,0,0,.8) inset;
}

.form-wrapper input::-webkit-input-placeholder {
   color: #999;
   font-weight: normal;
   font-style: italic;
}

.form-wrapper input:-moz-placeholder {
    color: #999;
    font-weight: normal;
}

.form-wrapper input:-ms-input-placeholder {
    color: #999;
    font-weight: normal;
}

/* Form submit button */
.form-wrapper button {
    overflow: visible;
    position: relative;
    float: right;
    border: 0;
    padding: 0;
    cursor: pointer;
    height: 40px;
    width: 110px;
    font: bold 15px/40px;
    color: #fff;
    text-transform: uppercase;
    background: #d83c3c;
    border-radius: 0 3px 3px 0;
    text-shadow: 0 -1px 0 rgba(0, 0 ,0, .3);
}

.form-wrapper button:hover{
    background: #e54040;
}

.form-wrapper button:active,
.form-wrapper button:focus{
    background: #c42f2f;
    outline: 0;
}

.form-wrapper button:before { /* left arrow */
    content: '';
    position: absolute;
    border-width: 8px 8px 8px 0;
    border-style: solid solid solid none;
    border-color: transparent #d83c3c transparent;
    top: 12px;
    left: -6px;
}

.form-wrapper button:hover:before{
    border-right-color: #e54040;
}

.form-wrapper button:focus:before,
.form-wrapper button:active:before{
        border-right-color: #c42f2f;
}

.form-wrapper button::-moz-focus-inner { /* remove extra button spacing for Mozilla Firefox */
    border: 0;
    padding: 0;
}

#outputs {
  width: 500px;
  margin: auto auto;
  border-radius: 10px;
  border: 1px solid #ccc;
}

#outputs > div {
  border-bottom: 1px solid #ddd;
}

#outputs > div > h3,
#outputs > div > h4 {
  margin: 4px auto;
  padding: 4px 0px;
  color: #444;
  text-decoration: none;
  font-size: 0.9em;
}

#outputs > div > h3 {
  font-weight: 600;
}

#outputs > div > h4 {
  font-weight: 800;
}
</style>
