package com.mycompany.mavenproject1;

import org.junit.Before;
import org.junit.Test;
import org.junit.After;
import static org.junit.Assert.*;

import java.sql.*;

public class ClassesTest {

    private DatabaseConnector dbConnector;
    private Connection connection;

    @Before
    public void setUp() throws Exception {
        // Set up the H2 in-memory database for testing
        dbConnector = new DatabaseConnector();
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1", "sa", "");
        Statement statement = connection.createStatement();
        // Check if the table exists and create it if not
        DatabaseMetaData dbm = connection.getMetaData();
        ResultSet tables = dbm.getTables(null, null, "ADMIN", null);
        if (!tables.next()) {
            statement.execute("CREATE TABLE Admin (AdminID INT, Name VARCHAR(255))");
        }
        statement.execute("TRUNCATE TABLE Admin");
        statement.execute("INSERT INTO Admin (AdminID, Name) VALUES (1, 'John Doe')");
        statement.execute("INSERT INTO Admin (AdminID, Name) VALUES (2, 'Jane Smith')");
        statement.close();
    }

    @After
    public void tearDown() throws Exception {
        if (connection != null && !connection.isClosed()) {
            try (Statement statement = connection.createStatement()) {
                statement.execute("DROP TABLE Admin");
            } catch (SQLException e) {
                System.err.println("Error dropping table: " + e.getMessage());
            }
            connection.close();
        }
    }


    @Test
    public void testConnect() {
        // Test if the connection method provides a valid connection
        try {
            Connection testConnection = dbConnector.connect();
            assertNotNull("Connection should not be null", testConnection);
        } catch (Exception e) {
            fail("Should not have thrown any exception");
        }
    }

    @Test
    public void testFetchAdminData() {
        try {
            // Directly use the method to fetch data from the in-memory database
            dbConnector = new DatabaseConnector() {
                @Override
                public Connection connect() {
                    return connection;  // Return the in-memory connection
                }
            };
            String result = dbConnector.fetchAdminData();
            assertTrue("Result should contain the name 'John Doe'", result.contains("John Doe"));
            assertTrue("Result should contain the name 'Jane Smith'", result.contains("Jane Smith"));
            System.out.println("Result: " + result); // Debug output to see what the actual result is
        } catch (Exception e) {
            fail("Should not have thrown any exception: " + e.getMessage());
        }
    }
    
    @Test
    public void testFetchNonExistentAdminData() {
        try {
            Statement statement = connection.createStatement();
            statement.execute("DELETE FROM Admin WHERE AdminID = 1"); // Remove an admin to test non-existence
            String result = dbConnector.fetchAdminData();
            assertFalse("Result should not contain deleted admin's name", result.contains("John Doe"));
            System.out.println("Non-existent admin test result: " + result);
        } catch (Exception e) {
            fail("Should not throw an exception: " + e.getMessage());
        }
    }
    @Test
    public void testSQLExceptionHandlingInFetchAdminData() {
        dbConnector = new DatabaseConnector() {
            @Override
            public Connection connect() throws SQLException {
                throw new SQLException("Forced SQLException for testing.");
            }
        };
        String result = dbConnector.fetchAdminData();
        assertTrue("Result should indicate an error occurred", result.contains("error") || result.contains("SQLException"));
    }
    
    @Test
    public void testConnectionClosing() {
        try {
            Connection testConnection = dbConnector.connect();
            dbConnector.fetchAdminData(); // Perform a fetch operation
            assertFalse("Connection should remain open after operation", testConnection.isClosed());
        } catch (Exception e) {
            fail("Should not have thrown any exception");
        }
    }
    @Test
    public void testDataIntegrityCheck() {
        try {
            Statement statement = connection.createStatement();
            statement.execute("INSERT INTO Admin (AdminID, Name) VALUES (3, NULL)");  // Intentionally inserting potentially problematic data

            String result = dbConnector.fetchAdminData();
            assertFalse("Data should not contain entries with null names", result.contains("ID: 3, Name: null"));
        } catch (SQLException e) {
            fail("Should not throw an exception during data integrity check: " + e.getMessage());
        }
    }
}
