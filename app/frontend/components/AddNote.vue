<template>
  <v-dialog
    transition="dialog-bottom-transition"
    max-width="600"
  >
    <template v-slot:activator="{ on, attrs }">
      <v-btn
        color="success"
        fab
        x-large
        fixed
        bottom
        right
        v-bind="attrs"
        v-on="on"
      >
        <v-icon>mdi-plus</v-icon>
      </v-btn>
    </template>
    <template v-slot:default="dialog">
      <v-card dark>
        <v-toolbar
          dark
        >
          Add new note
        </v-toolbar>
        <v-card-text>
          <v-form
            ref="form"
            v-model="formValid"
            lazy-validation
          >
            <v-text-field
              v-model="noteTitle"
              outlined
              required
              :rules="[v => !!v || 'Title is required']"
              label="Note Title"
              class="mt-5"
              @change="validateForm"
              @focus="validateForm"
            />
            <v-textarea
              v-model="noteBody"
              outlined
              required
              :rules="[v => !!v || 'Note body is required']"
              label="Note Body"
              @change="validateForm"
              @focus="validateForm"
            />
          </v-form>
        </v-card-text>
        <v-card-actions class="justify-end">
          <v-btn
            text
            color="error"
            :disabled="loading"
            @click="cancel(dialog)"
          >
            Cancel
          </v-btn>
          <v-btn
            :loading="loading"
            :disabled="!formValid"
            text
            @click="save(dialog)"
          >
            Save
          </v-btn>
        </v-card-actions>
      </v-card>
    </template>
  </v-dialog>
</template>

<script>
export default {
  name: 'AddNote',
  data: () => ({
    formValid: false,
    loading: false,
    noteTitle: '',
    noteBody: ''
  }),
  methods: {
    validateForm () {
      this.$refs.form.validate()
    },
    async save (dialog) {
      await this.createNote()
      this.$emit('note-saved')
      dialog.value = false
      this.noteTitle = ''
      this.noteBody = ''
      this.loading = false
    },
    createNote () {
      return new Promise((resolve, reject) => {
        this.$axios.post('/notes', {
          "note_title": this.noteTitle,
          "note_body": this.noteBody
        }).then(() => {
          resolve()
        }).catch(err => {
          reject(err)
        })
      })
    },
    cancel (dialog) {
      this.noteTitle = ''
      this.noteBody = ''
      dialog.value = false
    }
  }
}
</script>

