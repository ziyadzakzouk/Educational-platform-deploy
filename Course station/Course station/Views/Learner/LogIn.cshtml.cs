using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Course_station.Models;

namespace Course_station.Views.Learner
{
    public class LogInModel : PageModel
    {
        [BindProperty]
        public LoginViewModel LoginViewModel { get; set; }

        public void OnGet()
        {
        }

        public IActionResult OnPost()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            // Add your logic to authenticate the user here

            return RedirectToPage("Index"); // Redirect to a different page after successful login
        }
    }
}
