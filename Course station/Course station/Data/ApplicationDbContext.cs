// Data/ApplicationDbContext.cs
using Microsoft.EntityFrameworkCore;
using System;

namespace Course_station.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<Course> Courses { get; set; }
        // Add other DbSet properties for your tables.

    }
}
