def home_photos
    run_sql("SELECT * FROM home_pictures ORDER BY id")
end

def create_board(board_title, image_url)
    run_sql("INSERT INTO boards(board_title, image_url) VALUES($1, $2)", [board_title, image_url])
end

def get_photos(id, board_title, image_url)
    run_sql("SELECT board_title, image_url FROM boards")
end

def update_photos(title, id)
    run_sql("UPDATE boards SET title = $1 WHERE id = $2", [title, id])
end

def delete_photos(id)
    run_sql("DELETE FROM boards WHERE id = $1", [id])
end


# provide methods to access a particular resources from database table.