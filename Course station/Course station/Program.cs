using Course_station.Controllers;
using Course_station.Models;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

builder.Services.AddScoped<LearnerService>();

builder.Services.AddAuthorization(options =>
{
    options.AddPolicy("RequireAdminRole", policy => policy.RequireRole("Admin"));
    options.AddPolicy("RequireLearnerRole", policy => policy.RequireRole("Learner"));
    options.AddPolicy("RequireInstructorRole", policy => policy.RequireRole("Instructor"));
});
// Add authentication and authorization
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/Account/Login";
        options.AccessDeniedPath = "/Account/AccessDenied";
    });


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

using (var scope = app.Services.CreateScope())
{
    var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();
    var userManager = scope.ServiceProvider.GetRequiredService<UserManager<IdentityUser>>();

    string[] roleNames = { "Admin", "Instructor", "Learner" };
    IdentityResult roleResult;

    foreach (var roleName in roleNames)
    {
        var roleExist = roleManager.RoleExistsAsync(roleName).Result;
        if (!roleExist)
        {
            roleResult = roleManager.CreateAsync(new IdentityRole(roleName)).Result;
        }
    }

    var adminUser = new IdentityUser
    {
        UserName = "youssef.ashraf",
        Email = "youssef.ashraf@example.com"
    };

    string adminPassword = "20052099404Xx";
    var user = userManager.FindByEmailAsync("youssef.ashraf@example.com").Result;

    if (user == null)
    {
        var createAdminUser = userManager.CreateAsync(adminUser, adminPassword).Result;
        if (createAdminUser.Succeeded)
        {
            userManager.AddToRoleAsync(adminUser, "Admin").Wait();
        }
    }
}

app.Run();
