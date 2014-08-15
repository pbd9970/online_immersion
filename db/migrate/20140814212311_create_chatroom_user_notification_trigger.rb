class CreateChatroomUserNotificationTrigger < ActiveRecord::Migration
  def up
    execute %q[
      CREATE FUNCTION notify_new_chatroomUser() RETURNS trigger AS $$
      DECLARE
      BEGIN
        PERFORM pg_notify('new_chatroomUser', '{ chatroom_id: ' || NEW.chatroom_id || ', user_id: ' || NEW.user_id || '}');
        RETURN new;
      END;
      $$ LANGUAGE plpgsql;
    ]

    execute %q[
      CREATE TRIGGER chatroom_users_insertion_trigger AFTER INSERT ON chatroom_users
      FOR EACH ROW EXECUTE PROCEDURE notify_new_chatroomUser();
    ]

    end
  
  def down
    execute 'DROP TRIGGER chatroom_users_insertion_trigger ON chatroom_users;'
    execute 'DROP FUNCTION notify_new_chatroomUser();'
  end
end
