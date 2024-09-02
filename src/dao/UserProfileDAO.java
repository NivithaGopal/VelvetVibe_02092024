package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import bean.UserProfileBean;
import dbconnection.DBConnection;

public class UserProfileDAO {

    // Method to get user by email
    public UserProfileBean getUserByEmail(String email) {
        UserProfileBean user = null;
        String sql = "SELECT ur.fullName, ur.dob, ur.email FROM user_registration ur WHERE ur.email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new UserProfileBean();
                //user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("fullName"));
                user.setDob(rs.getDate("dob"));
                user.setEmail(rs.getString("email"));
                //user.setPassword(rs.getString("password"));
                // Note: `address` is not in this table, so not setting it here
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    // Method to update user profile
	/*
	 * public boolean updateUserProfile(UserProfileBean user) { String sql =
	 * "UPDATE user_registration SET fullName = ?, dob = ? WHERE email = ?";
	 * 
	 * try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt =
	 * conn.prepareStatement(sql)) {
	 * 
	 * stmt.setString(1, user.getFullName()); stmt.setDate(2, user.getDob());
	 * stmt.setString(3, user.getEmail());
	 * 
	 * int rowsUpdated = stmt.executeUpdate(); return rowsUpdated > 0;
	 * 
	 * } catch (SQLException e) { e.printStackTrace(); }
	 * 
	 * return false; }
	 */
    public boolean insertUserProfile(UserProfileBean user) {
        boolean inserted = false;
        String query = "INSERT INTO user_profile (fullName, dob, email, address) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, user.getFullName());
            ps.setDate(2, new java.sql.Date(user.getDob().getTime()));
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getAddress());

            int rowsAffected = ps.executeUpdate();
            inserted = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inserted;
    }

 
    public boolean updateUserProfile(UserProfileBean user) {
        boolean updated = false;
        String query = "UPDATE user_profile SET fullName = ?, dob = ?, address = ? WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, user.getFullName());
            ps.setDate(2, new java.sql.Date(user.getDob().getTime()));
            ps.setString(3, user.getAddress());
            ps.setString(4, user.getEmail());

            int rowsAffected = ps.executeUpdate();
            updated = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return updated;
    }
}
