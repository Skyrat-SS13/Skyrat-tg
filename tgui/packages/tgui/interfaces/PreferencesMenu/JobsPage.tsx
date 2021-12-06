import { sortBy } from "common/collections";
import { classes } from "common/react";
import { InfernoNode, SFC } from "inferno";
import { useBackend } from "../../backend";
import { Box, Button, Dropdown, Stack, Tooltip } from "../../components";
import { createSetPreference, Job, JoblessRole, JobPriority, PreferencesMenuData } from "./data";
import { ServerPreferencesFetcher } from "./ServerPreferencesFetcher";

const sortJobs = (
  entries: [string, Job][],
  head?: string,
) => sortBy<[string, Job]>(
  ([key, _]) => key === head ? -1 : 1,
  ([key, _]) => key,
)(entries);

const PRIORITY_BUTTON_SIZE = "18px";

const PriorityButton = (props: {
  name: string,
  color: string,
  modifier?: string,
  enabled: boolean,
  onClick: () => void,
}) => {
  const className = `PreferencesMenu__Jobs__departments__priority`;

  return (
    // SKYRAT EDIT START
    <Button
      className={classes([
        className,
        props.modifier && `${className}--${props.modifier}`,
      ])}
      color={props.enabled ? props.color : "white"}
      circular
      onClick={props.onClick}
      tooltip={props.name}
      tooltipPosition="bottom"
      height={PRIORITY_BUTTON_SIZE}
      width={PRIORITY_BUTTON_SIZE}
    />
    // SKYRAT EDIT END
  );
};

type CreateSetPriority = (priority: JobPriority | null) => () => void;

const createSetPriorityCache: Record<string, CreateSetPriority> = {};

const createCreateSetPriorityFromName
  = (context, jobName: string): CreateSetPriority => {
    if (createSetPriorityCache[jobName] !== undefined) {
      return createSetPriorityCache[jobName];
    }

    const perPriorityCache: Map<JobPriority | null, () => void> = new Map();

    const createSetPriority = (priority: JobPriority | null) => {
      const existingCallback = perPriorityCache.get(priority);
      if (existingCallback !== undefined) {
        return existingCallback;
      }

      const setPriority = () => {
        const { act } = useBackend<PreferencesMenuData>(context);

        act("set_job_preference", {
          job: jobName,
          level: priority,
        });
      };

      perPriorityCache.set(priority, setPriority);
      return setPriority;
    };

    createSetPriorityCache[jobName] = createSetPriority;

    return createSetPriority;
  };

const PriorityHeaders = () => {
  const className = "PreferencesMenu__Jobs__PriorityHeader";

  return (
    <Stack>
      <Stack.Item grow />

      <Stack.Item className={className}>
        Off
      </Stack.Item>

      <Stack.Item className={className}>
        Low
      </Stack.Item>

      <Stack.Item className={className}>
        Medium
      </Stack.Item>

      <Stack.Item className={className}>
        High
      </Stack.Item>
    </Stack>
  );
};

const PriorityButtons = (props: {
  createSetPriority: CreateSetPriority,
  isOverflow: boolean,
  priority: JobPriority,
}) => {
  const { createSetPriority, isOverflow, priority } = props;

  return (
    <Box inline // SKYRAT EDIT
      style={{
        "align-items": "center",
        "height": "100%",
        "textAlign": "end", // SKYRAT EDIT
        "padding": "0.3em", // SKYRAT EDIT
      }}
    >
      {isOverflow
        ? (
          <>
            <PriorityButton
              name="Off"
              modifier="off"
              color="light-grey"
              enabled={!priority}
              onClick={createSetPriority(null)}
            />

            <PriorityButton
              name="On"
              color="green"
              enabled={!!priority}
              onClick={createSetPriority(JobPriority.High)}
            />
          </>
        )
        : (
          <>
            <PriorityButton
              name="Off"
              modifier="off"
              color="light-grey"
              enabled={!priority}
              onClick={createSetPriority(null)}
            />

            <PriorityButton
              name="Low"
              color="red"
              enabled={priority === JobPriority.Low}
              onClick={createSetPriority(JobPriority.Low)}
            />

            <PriorityButton
              name="Medium"
              color="yellow"
              enabled={priority === JobPriority.Medium}
              onClick={createSetPriority(JobPriority.Medium)}
            />

            <PriorityButton
              name="High"
              color="green"
              enabled={priority === JobPriority.High}
              onClick={createSetPriority(JobPriority.High)}
            />
          </>
        )}
    </Box> // SKYRAT EDIT
  );
};

const JobRow = (props: {
  className?: string,
  job: Job,
  name: string,
}, context) => {
  const { data } = useBackend<PreferencesMenuData>(context);
  const { className, job, name } = props;

  const isOverflow = data.overflow_role === name;
  const priority = data.job_preferences[name];

<<<<<<< HEAD
  const createSetPriority = createCreateSetPriorityFromName(context, job.name);
  // SKYRAT EDIT
  const { act } = useBackend<PreferencesMenuData>(context);
  // SKYRAT EDIT END

  const experienceNeeded = data.job_required_experience
    && data.job_required_experience[job.name];
  const daysLeft = data.job_days_left ? data.job_days_left[job.name] : 0;
  // SKYRAT EDIT
  const alt_title_selected = data.job_alt_titles[job.name]
    ? data.job_alt_titles[job.name] : job.name;
  // SKYRAT EDIT END
=======
  const createSetPriority = createCreateSetPriorityFromName(context, name);

  const experienceNeeded = data.job_required_experience
    && data.job_required_experience[name];
  const daysLeft = data.job_days_left ? data.job_days_left[name] : 0;
>>>>>>> 0989ce2d6fd (Remove job .tsx files from preferences menu, use compiled data instead (#63200))

  let rightSide: InfernoNode;

  if (experienceNeeded) {
    const { experience_type, required_playtime } = experienceNeeded;
    const hoursNeeded = Math.ceil(required_playtime / 60);

    rightSide = (
      <Stack align="center" height="100%" pr={1}>
        <Stack.Item grow textAlign="right">
          <b>{hoursNeeded}h</b> as {experience_type}
        </Stack.Item>
      </Stack>
    );
  } else if (daysLeft > 0) {
    rightSide = (
      <Stack align="center" height="100%" pr={1}>
        <Stack.Item grow textAlign="right">
          <b>{daysLeft}</b> day{daysLeft === 1 ? "" : "s"} left
        </Stack.Item>
      </Stack>
    );
  } else if (data.job_bans && data.job_bans.indexOf(name) !== -1) {
    rightSide = (
      <Stack align="center" height="100%" pr={1}>
        <Stack.Item grow textAlign="right">
          <b>Banned</b>
        </Stack.Item>
      </Stack>
    );
  // SKYRAT EDIT
  } else if (job.veteran && !data.is_veteran) {
    rightSide = (
      <Stack align="center" height="100%" pr={1}>
        <Stack.Item grow textAlign="right">
          <b>Veteran Only</b>
        </Stack.Item>
      </Stack>
    );
  } else if (data.species_restricted_jobs
            && data.species_restricted_jobs.indexOf(job.name) !== -1) {
    rightSide = (
      <Stack align="center" height="100%" pr={1}>
        <Stack.Item grow textAlign="right">
          <b>Bad species</b>
        </Stack.Item>
      </Stack>
    );
  // SKYRAT EDIT END
  } else {
    rightSide = (<PriorityButtons
      createSetPriority={createSetPriority}
      isOverflow={isOverflow}
      priority={priority}
    />);
  }
  return (
<<<<<<< HEAD
    <Box className={props.className} style={{ // SKYRAT EDIT
=======
    <Stack.Item className={className} height="100%" style={{
>>>>>>> 0989ce2d6fd (Remove job .tsx files from preferences menu, use compiled data instead (#63200))
      "margin-top": 0,
    }}>
      <Stack align="center" /* SKYRAT EDIT */>
        <Tooltip
          content={job.description}
          position="right"// SKYRAT EDIT bottom-start->right
        >
          <Stack.Item className="job-name" width="50%" style={{
            "padding-left": "0.3em",
<<<<<<< HEAD
          }}> { // SKYRAT EDIT
              (!job.alt_titles ? job.name : <Dropdown
                width="100%"
                options={job.alt_titles}
                displayText={alt_title_selected}
                onSelected={(value) => act("set_job_title", { job: job.name, new_title: value })}
              />)
            // SKYRAT EDIT END
            }
=======
          }}>

            {name}
>>>>>>> 0989ce2d6fd (Remove job .tsx files from preferences menu, use compiled data instead (#63200))
          </Stack.Item>
        </Tooltip>

        <Stack.Item width="50%" className="options" /* SKYRAT EDIT */>
          {rightSide}
        </Stack.Item>
      </Stack>
    </Box> // SKYRAT EDIT
  );
};

const Department: SFC<{ department: string}> = (props) => {
  const { children, department: name } = props;
  const className = `PreferencesMenu__Jobs__departments--${name}`;

  return (
<<<<<<< HEAD
    // SKYRAT EDIT START
    <Box className="jobRow">
      {jobs.head
        && <JobRow className={`${className} head`} job={jobs.head} />}
      {jobs.jobs.map((job) => {
        if (job === jobs.head) {
          return null;
        }

        return <JobRow className={className} key={job.name} job={job} />;
      })}
    </Box>
    // SKYRAT EDIT END
=======
    <ServerPreferencesFetcher
      render={(data) => {
        if (!data) {
          return null;
        }

        const { departments, jobs } = data.jobs;
        const department = departments[name];

        // This isn't necessarily a bug, it's like this
        // so that you can remove entire departments without
        // having to edit the UI.
        // This is used in events, for instance.
        if (!department) {
          return null;
        }

        const jobsForDepartment = sortJobs(
          Object.entries(jobs).filter(
            ([_, job]) => job.department === name
          ),
          department.head
        );

        return (
          <Box>
            <Stack
              vertical
              fill>
              {jobsForDepartment.map(([name, job]) => {
                return (<JobRow
                  className={classes([className, name === department.head && "head"])}
                  key={name}
                  job={job}
                  name={name}
                />);
              })}
            </Stack>

            {children}
          </Box>
        );
      }}
    />
>>>>>>> 0989ce2d6fd (Remove job .tsx files from preferences menu, use compiled data instead (#63200))
  );
};

// *Please* find a better way to do this, this is RIDICULOUS.
// All I want is for a gap to pretend to be an empty space.
// But in order for everything to align, I also need to add the 0.2em padding.
// But also, we can't be aligned with names that break into multiple lines!
const Gap = (props: {
  amount: number,
}) => {
  // 0.2em comes from the padding-bottom in the department listing
  return <Box height={`calc(${props.amount}px + 0.2em)`} />;
};

const JoblessRoleDropdown = (props, context) => {
  const { act, data } = useBackend<PreferencesMenuData>(context);
  const selected = data.character_preferences.misc.joblessrole;

  const options = [
    {
      displayText: `Join as ${data.overflow_role} if unavailable`,
      value: JoblessRole.BeOverflow,
    },
    {
      displayText: `Join as a random job if unavailable`,
      value: JoblessRole.BeRandomJob,
    },
    {
      displayText: `Return to lobby if unavailable`,
      value: JoblessRole.ReturnToLobby,
    },
  ];

  return (
    <Box
      position="absolute"
      right={0}
      width="30%"
    >
      <Dropdown
        width="100%"
        selected={selected}
        onSelected={createSetPreference(act, "joblessrole")}
        options={options}
        displayText={
          <Box pr={1}>
            {options.find(option => option.value === selected)!.displayText}
          </Box>
        }
      />
    </Box>
  );
};

export const JobsPage = () => {
  return (
    <>
      <JoblessRoleDropdown />

      <Stack vertical fill>
        <Gap amount={22} />

        <Stack.Item>
          <Stack fill className="PreferencesMenu__Jobs">
            <Stack.Item mr={1}>
              <Gap amount={36} />

              <PriorityHeaders />

              <Department department="Engineering">
                <Gap amount={6} />
              </Department>

              <Department department="Science">
                <Gap amount={6} />
              </Department>

              <Department department="Silicon">
                <Gap amount={12} />
              </Department>

              <Department
                department="Assistant"
              />
            </Stack.Item>

            <Stack.Item mr={1}>
              <PriorityHeaders />

              <Department department="Captain">
                <Gap amount={6} />
              </Department>

              <Department department="Service">
                <Gap amount={6} />
              </Department>

              <Department department="Cargo" />
            </Stack.Item>

            <Stack.Item>
              <Gap amount={36} />

              <PriorityHeaders />

              <Department department="Security">
                <Gap amount={6} />
              </Department>

              <Department
                department="Medical"
              />
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </>
  );
};
