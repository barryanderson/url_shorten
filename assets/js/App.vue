<template>
  <b-container fluid>
    <b-row>
      <b-col>
        <h1>URL Shortener</h1>
        <p>A fast URL shortener implemented with the Phoenix Framework and Vue.js.  For more information visit the <a href="https://github.com/barryanderson/url_shorten">GitHub page</a>.</p>
      </b-col>
    </b-row>
    
    <b-row>
      <b-col>
        <b-form @submit.prevent="shorten">
          <b-input-group>
            <b-form-input
              id="url_input"
              v-model="user_url"
              required
            ></b-form-input>
            <b-input-group-append>
              <b-button 
                @click.prevent="shorten"
                variant="success">Shorten
              </b-button>
            </b-input-group-append>
          </b-input-group>
          <b-form-invalid-feedback :state="validation">
            {{user_error}}.
          </b-form-invalid-feedback>
        </b-form>
      </b-col>
    </b-row>

    <b-row>
      <b-col>
        <b-card-group
          v-if="shortened.length > 0"
          class="m-2"
          fade
          deck>
          <b-card header="Shortened Links">
            <b-list-group>
              <b-list-group-item v-for="item in shortened" :key="item.new" class="links">
                <div class="old_link">{{item.old}}</div>
                <div class="new_link">
                  <a 
                    :href="item.new"
                    target="_blank"
                  >{{item.new}}</a>
                </div>
              </b-list-group-item>
            </b-list-group>
          </b-card>
        </b-card-group>
      </b-col>
    </b-row>

  </b-container >
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
      shortened: []
    }
  },
  computed: {
    validation () {
      return this.user_error == null || this.user_error.length <= 0
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
.old_link {
  font-size: 0.7em;
}
</style>
