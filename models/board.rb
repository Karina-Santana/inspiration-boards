def all_photos
    run_sql("SELECT * FROM home_pictures ORDER BY id")
end

def creat_board(board_title, image_url, picture_title)
    run_sql("INSERT INTO home_pictures(board_title, image_url, picture_title) VALUES($1, $2, $3)", [board_title, image_url, picture_title])
end

def get_photos(id)
    run_sql("SELECT * FROM home_pictures WHERE id = $1", [id])[0]
end

def update_photos(title, id)
    run_sql("UPDATE home_pictures SET title = $1 WHERE id = $2", [title, id])
end

def delete_photos(id)
    run_sql("DELETE FROM home_pictures WHERE id = $1", [id])
end




# provide methods to access a particular resources from database table.