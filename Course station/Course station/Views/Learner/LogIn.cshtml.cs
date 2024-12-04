using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Course_station.Models;

namespace Course_station.Views.Learner
{
    public class LogInModel : PageModel
    {
        [BindProperty]
        public Course_station.Models.Learner LoginViewModel { get; set; }

        public void OnGet()
        {
        }

        public IActionResult OnPost()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            // Dummy authentication logic for demonstration purposes
            // Replace this with your actual authentication logic
            if (LoginViewModel.Email == "test@example.com" && LoginViewModel.Password == "password")
            {
                // Redirect to the home page after successful login
                return RedirectToPage("/Index");
            }

            // If authentication fails, add a model error
            ModelState.AddModelError(string.Empty, "Invalid login attempt.");
            return Page();
        }
    }
}
