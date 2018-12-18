<template>
  <div id="app">
    <div>
      <input type="text" name="user_url" id="user_url" v-model="user_url"/>
      <input type="button" value="Shorten" v-on:click="test">
    </div>
    <ul id="shortened">
      <li v-for="item in shortened" v-bind:key="item.new">
        {{item.new}} : {{item.old}}
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'app',
  components: {
  },
  data () {
    return {
      user_url: "",
      shortened: []
    }
  },
  methods: {
    test () {
      axios.post('/api', {
        "url": this.user_url
      })
      .then((response) => {
        this.user_url = ""
        this.shortened.push({new: response.data.data.hash, old: response.data.data.url})
      })
      .catch((error) => {
        console.log(error)
      })
    }
  }
}
</script>

<style>
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
</style>
