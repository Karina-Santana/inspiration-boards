def create_user(name, email, password)
    password_digest = BCrypt::Password.create(password)

    run_sql("INSERT INTO users(name, email, password_digest) VALUES($1, $2, $3)", [name, email, password_digest])
end

def find_user_by_email(email)
    users = run_sql("SELECT * FROM users WHERE email = $1", [email])

    if users.to_a.count > 0
        users[0]
    else
        nil
    end
end

def find_user_by_id(id)
    run_sql("SELECT * FROM users WHERE id = $1", [id])[0]
end

def find_board_by_user_id(user_id)
    run_sql("SELECT * FROM boards WHERE user_id = $1", [user_id])[0]
end