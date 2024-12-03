
    using System;
    using System.Linq;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    using Course_station.Models;
    using global::Course_station.Models;

    namespace Course_station.Controllers
    {
        [Route("api/[controller]")]
        [ApiController]
        public class AchievementsController : ControllerBase
        {
            private readonly DbContext _context;

            public AchievementsController(DbContext context)
            {
                _context = context;
            }

            // GET: api/Achievements
            [HttpGet]
            public async Task<IActionResult> GetAchievements()
            {
                var achievements = await _context.Set<Achievement>()
                                                 .Include(a => a.Badge)
                                                 .Include(a => a.Learner)
                                                 .ToListAsync();
                return Ok(achievements);
            }

            // GET: api/Achievements/5
            [HttpGet("{id}")]
            public async Task<IActionResult> GetAchievement(int id)
            {
                var achievement = await _context.Set<Achievement>()
                                                .Include(a => a.Badge)
                                                .Include(a => a.Learner)
                                                .FirstOrDefaultAsync(a => a.AchievementId == id);

                if (achievement == null)
                    return NotFound();

                return Ok(achievement);
            }

            // POST: api/Achievements
            [HttpPost]
            public async Task<IActionResult> CreateAchievement([FromBody] Achievement achievement)
            {
                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                _context.Set<Achievement>().Add(achievement);
                await _context.SaveChangesAsync();

                return CreatedAtAction(nameof(GetAchievement), new { id = achievement.AchievementId }, achievement);
            }

            // PUT: api/Achievements/5
            [HttpPut("{id}")]
            public async Task<IActionResult> UpdateAchievement(int id, [FromBody] Achievement achievement)
            {
                if (id != achievement.AchievementId)
                    return BadRequest();

                if (!ModelState.IsValid)
                    return BadRequest(ModelState);

                _context.Entry(achievement).State = EntityState.Modified;

                try
                {
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!AchievementExists(id))
                        return NotFound();
                    else
                        throw;
                }

                return NoContent();
            }

            // DELETE: api/Achievements/5
            [HttpDelete("{id}")]
            public async Task<IActionResult> DeleteAchievement(int id)
            {
                var achievement = await _context.Set<Achievement>().FindAsync(id);
                if (achievement == null)
                    return NotFound();

                _context.Set<Achievement>().Remove(achievement);
                await _context.SaveChangesAsync();

                return NoContent();
            }

            private bool AchievementExists(int id)
            {
                return _context.Set<Achievement>().Any(e => e.AchievementId == id);
            }
        }
    }

