import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user") // Added to prefix all routes in this controller
public class UserController {

    private static Map<String, UserModel> users = new HashMap<>(); // user database

    @GetMapping("/register")
    public String showRegistrationForm() {
        return "register"; 
    }

    @PostMapping("/register")
    public String register(UserModel user) {
        // Simulate saving the user to a database
        if(!users.containsKey(user.getUsername())) {
            users.put(user.getUsername(), user); 
            return "redirect:/user/login";
        } else {
            // Username dup
            return "redirect:/user/register?error=username";
        }
    }

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password) {
        // Authenticate the user
        UserModel user = users.get(username);
        if(user != null && user.getPassword().equals(password)) {
            return "redirect:/home"; // successful login
        } else {
            return "redirect:/user/login?error=invalid"; // error
        }
    }
}
