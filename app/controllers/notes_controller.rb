class NotesController < ApplicationController
  def index
    render json: Note.all
  end

  def show
    note_id = params[:note_id] # extract the note id from the URL param (see routes.rb for where this is defined)
    # use SQL or, preferably, Active Record to fetch the note from the database (https://guides.rubyonrails.org/active_record_querying.html#retrieving-objects-from-the-database)
    # render the note as json with a 200 status
  end

  def create
    note = Note.new(title: params[:note_title], body: params[:note_body])
    if note.save
      render json: note, status: :created
    else
      render json: {}, status: :bad_request
    end
  end

  def destroy
  end
end
