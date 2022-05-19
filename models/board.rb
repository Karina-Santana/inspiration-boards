def all_photos
    run_sql("SELECT * FROM boards ORDER BY id")
end

def get_photos(id)
    run_sql("SELECT * FROM boards WHERE id = $1", [id])[0]
end

def update_photos(title, id)
    run_sql("UPDATE boards SET title = $1 WHERE id = $2", [title, id])
end

def delete_photos(id)
    run_sql("DELETE FROM boards WHERE id = $1", [id])
end
