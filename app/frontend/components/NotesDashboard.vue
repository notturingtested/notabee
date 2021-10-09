<template>
  <v-container class="pt-5 mt-5">
    <div v-if="!notes.length">
      Loading...
    </div>
    <div v-else>
      <v-row>
        <template v-for="note in notes">
          <v-col
            :key="`note-${note.id}`"
            sm="3"
          >
            <Note
              :note="note"
            />
          </v-col>
        </template>
      </v-row>
    </div>
    <AddNote
      @note-saved="fetchNotes"
    />
  </v-container> 
</template>

<script>
import Note from './Note.vue'
import AddNote from './AddNote.vue'

export default {
  name: 'NotesDashboard',
  components: {
    AddNote,
    Note
  },
  created () {
    this.fetchNotes()
  },
  data: () => ({
    notes: []
  }),
  methods: {
    async fetchNotes() {
      let response = await this.$axios.get("/notes")
      this.notes = response.data
    }
  }
}
</script>

