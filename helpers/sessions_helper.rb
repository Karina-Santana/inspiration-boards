def logged_in?
    #when there is a ? the answer is always true or false
    if session['user_id']
        return true
    else
        return false
    end
end

def current_user
    if logged_in?
        find_user_by_id(session['user_id'])
    else
        nil
    end
end
# no database
# helpers are files which store the methods for views
