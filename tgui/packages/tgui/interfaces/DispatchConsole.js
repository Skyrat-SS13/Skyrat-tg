import { useBackend } from '../backend';
import { Button, LabeledList, NoticeBox, Section } from '../components';
import { ButtonCheckbox } from '../components/Button';
import { Window } from '../layouts';

export const DispatchConsole = (props, context) => {
  return (
    <Window>
      <HolderReport />
    </Window>
  );
};

export const HolderReport = (props, context) => {
  const { data, act } = useBackend(context);
  const { self_ref, holder } = data;
  const { list, lookup, status, ticket, activity, location } = holder;

  return (
    <Section title="Holder Report" buttons={
      <Button
        content="Refresh"
        color="blue"
        onClick={() => act("refresh", { self_ref: self_ref })} />
    }>
      {list.map((_h) => (
        // If their suit sensors are disabled don't show them
        status[_h] !== 0 && (
          <LabeledList.Item
            label={lookup[_h]}
            buttons={
              <>
                <ButtonCheckbox // Assign/Cancel ticket
                  content={ticket[_h] === "None" ? "Assign Ticket" : ticket[_h]}
                  checked={ticket[_h] !== "None"}
                  // If they aren't active you can't assign them a ticket
                  disabled={!activity[_h]}
                  onClick={() => act("assign-ticket", { self_ref: self_ref, holder_ref: _h })}
                />
                <Button
                  content="Remove Ticket"
                  disabled={ticket[_h] === "None"}
                  color="bad"
                  onClick={() => act("eject-ticket", { self_ref: self_ref, holder_ref: _h })}
                />
              </>
            }
          >
            {!activity[_h] && (
              <NoticeBox>Holder Inactive</NoticeBox>
            ) || ( // Yes I know we have a string here instead of a number. Cope
              <b>{status[_h] === "3" ? location[_h] : "Unknown Location"}</b>
            )}
          </LabeledList.Item>
        )
      ))}
    </Section>
  );
};
