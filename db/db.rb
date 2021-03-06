require 'pg'

def run_sql(sql, params = [])
    db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'inspiration_board'})
    results = db.exec_params(sql, params)
    db.close
    results
end
