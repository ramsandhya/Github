How popular is this project (based on number of stars)?

select
    project.name, project.stars
from
    project
order by
    project.stars desc;
How many projects does this user have?
select
    coder.name,
    count(project.id) as count
from
    project
left outer join
    project_membership on project.id = project_membership.project_id
left outer join
    coder on project_membership.coder_id = coder.id
group by
    coder.name;

List this users projects.

select
    project.name,
    coder.name
from
    project
left outer join
    project_membership on project.id = project_membership.project_id
left outer join
    coder on project_membership.coder_id = coder.id
order by
    coder.name;

What are this users top 3 projects based on number of stars?

select
    coder.name,
    project.name,
    project.stars
from
    project
left outer join
    project_membership on project.id = project_membership.project_id
left outer join
    coder on project_membership.coder_id = coder.id
where
    coder.name in ('Allen') -- can change to whichever coder
order by
    project.stars desc
limit
    3;

What are the top 3 projects overall based on the number of tech used?

select
    project.name,
    count(tech.name) as tech_count
from
    project
left outer join
    project_uses_tech on project.id = project_uses_tech.project_id
left outer join
    tech on tech.id = project_uses_tech.tech_id
group by
    project.id
order by
    tech_count desc
limit
    3;

Are there more than one project with the same name?

select
    project.name,
    count(project.name) as num_of_projects
from
    project
group by
    project.name
having
    count(project.name) > 1;

How many contributors does each project have (include even projects that have no contributors)?

select
    project.name,
    sum(case when coder.id is NULL then 0 else 1 end) as coder_count
from
    project
left outer join
    project_membership on project.id = project_membership.project_id
left outer join
    coder on project_membership.coder_id = coder.id
group by
    project.id
order by
    coder_count desc;

How many projects does each user have (include even users that have no projects)?

select
    coder.name,
    sum(case when project.id is NULL then 0 else 1 end) as project_count
from
    coder
left outer join
    project_membership on coder.id = project_membership.coder_id
left outer join
    project on project_membership.project_id = project.id
group by
    coder.id
order by
    project_count desc;

What is the average number of commits on a project?

select
    avg(count)
from
(
select
    project.name,
    count(commits.id)
from
    project
left outer join
    commits on project.id = commits.project_id
group by
    project.id
) as average_commits;

What is the average number of contributors on a project?

select
    avg(coder_count)
from
(
select
    project.name,
    sum(case when coder.id is NULL then 0 else 1 end) as coder_count
from
    project
left outer join
    project_membership on project.id = project_membership.project_id
left outer join
    coder on project_membership.coder_id = coder.id
group by
    project.id
order by
    coder_count desc
) as avg_contributors;

What is the average number of stars on a project?

select
    avg(stars)
from
(
select
    project.name, project.stars as stars
from
    project
order by
    project.stars desc
) as avg_stars;

Who are the contributors to this project?

select
    DISTINCT project.name,
    coder.name
from
    project
left outer join
    project_membership on project.id = project_membership.project_id
left outer join
    coder on project_membership.coder_id = coder.id
where
    project.name in ('Canvas Game')
order by
    project.name;

Who made the most PRs (pull requests) to this project?
What is this user's PR acceptence rate (ratio of PRs merged vs PRs unmerged)?
What tech does this project use?
What tech does this user know - based on the tech used in his projects?
Who are the top 3 contributors to this project based on number of commits?
What are this user's top 3 projects based on number of commits?
Write a query to enable plotting a project's commit activity by date.
Write a query to enable plotting a user's number of commits by date.
