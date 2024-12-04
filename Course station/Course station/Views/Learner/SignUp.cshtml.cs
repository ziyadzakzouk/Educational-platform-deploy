using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Course_station.Models;

namespace Course_station.Views.Learner
{
    public class SignUpModel : PageModel
    {
        [BindProperty]
        public Course_station.Models.Learner Learner { get; set; }

        public void OnGet()
        {
        }

        public IActionResult OnPost()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            // Add your logic to save the learner to the database here

            return RedirectToPage("LogIn");
        }
    }
}
