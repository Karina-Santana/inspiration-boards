def home_photos
    run_sql("SELECT * FROM home_pictures ORDER BY id")
end

def create_board(board_title, image_url, user_id)
    run_sql("INSERT INTO boards(board_title, image_url, user_id) VALUES($1, $2, $3)", [board_title, image_url, user_id])
end

def get_photos(id)
    run_sql("SELECT * FROM boards WHERE id = $1", [id])[0]
end

def board_photos(user_id)
    run_sql("SELECT * FROM boards WHERE user_id = $1", [user_id])
end

def board_title(board_title)
    run_sql("SELECT * FROM boards WHERE board_title = $1", [board_title])
end

def get_user_board(id)
    run_sql("SELECT * FROM boards WHERE user_id = $1", [id])
end

def update_photos(title, id)
    run_sql("UPDATE boards SET title = $1 WHERE id = $2", [title, id])
end

def delete_photos(id)
    run_sql("DELETE FROM boards WHERE id = $1", [id])
end


# provide methods to access a particular resources from database table.