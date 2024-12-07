using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace Course_station.Controllers
{
    public class AccountController : Controller
    {
        private readonly UserManager<IdentityUser> _userManager;

        public AccountController(UserManager<IdentityUser> userManager)
        {
            _userManager = userManager;
        }

        public async Task<IActionResult> AssignRole(string userId, string role)
        {
            var user = await _userManager.FindByIdAsync(userId);
            if (user != null)
            {
                var result = await _userManager.AddToRoleAsync(user, role);
                if (result.Succeeded)
                {
                    return Ok("Role assigned successfully");
                }
                else
                {
                    return BadRequest("Failed to assign role");
                }
            }
            return NotFound("User not found");
        }
    }
}
