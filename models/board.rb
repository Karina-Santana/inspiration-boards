def home_photos
    run_sql("SELECT * FROM home_pictures ORDER BY id")
end

def create_board(board_title, user_id)
    run_sql("INSERT INTO boards(board_title, user_id) VALUES($1, $2) RETURNING id", [board_title, user_id])[0]
end

def create_images(board_id, image_url)
    run_sql("INSERT INTO images(board_id, image_url) VALUES($1, $2)", [board_id, image_url])
end

def get_images(id)
    run_sql("SELECT * FROM images WHERE board_id = $1", [id])
end

def boards_by_user(user_id)
    run_sql("SELECT * FROM boards WHERE user_id = $1", [user_id])
end

def get_user_board(id)
    run_sql("SELECT * FROM boards WHERE user_id = $1", [id])
end

def get_board(id)
    run_sql("SELECT * FROM boards WHERE id = $1", [id])[0]
end

def update_board(board_title, id)
    run_sql("UPDATE boards SET board_title = $1 WHERE id = $2", [board_title, id])
end

def delete_image(id)
    run_sql("DELETE FROM images WHERE id = $1", [id])
end

def delete_board(id)
    run_sql("DELETE FROM boards WHERE id = $1", [id])
end


# provide methods to access a particular resources from database table.