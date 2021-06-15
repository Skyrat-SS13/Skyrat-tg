
import { useBackend } from '../backend';
import { Button, Section } from '../components';
import { ButtonCheckbox } from '../components/Button';
import { Window } from '../layouts';

export const TicketBrowser = (props, context) => {
  const { data } = useBackend(context);
  const { mdata, tdata } = data;
  const { ticketActive, ticketData } = mdata;
  const { imageAttached } = ticketData;
  return (
    <Window title="Ticket Browser" height={400} width={800}>
      <HolderToggles />
      <TicketSelector />
      {ticketActive !== "None" && (
        <>
          <TicketInformation />
          {!!imageAttached && (
            <TicketImage />
          )}
        </>
      )}
    </Window>
  );
};

const HolderToggles = (props, context) => {
  const { data, act } = useBackend(context);
  const { mdata, self_ref } = data;
  const { holderActive, holderActiveType, holderClocked, holderName } = mdata;

  return (
    <Section title={"Holder - " + holderName} buttons={
      <>
        <ButtonCheckbox
          content={holderActive ? holderActiveType : "Active"}
          disabled={!holderClocked}
          checked={holderActive}
          color={holderActive ? "green" : "red"}
          onClick={() => act("toggle-active", { self_ref: self_ref })}
        />
        <ButtonCheckbox
          content={"Clocked " + (holderClocked ? "In" : "Out")}
          checked={holderClocked}
          color={holderClocked ? "green" : "red"}
          onClick={() => act("toggle-clocked", { self_ref: self_ref })}
        />
      </>
    } />
  );
};

const TicketSelector = (props, context) => {
  const { data, act } = useBackend(context);
  const { mdata, self_ref } = data;
  const { ticketActive, holderActive } = mdata;

  return (
    <Section title={"Ticket Selected: " + ticketActive} buttons={
      <>
        <Button
          content="Clear Ticket"
          color="yellow"
          disabled={ticketActive === "None"}
          onClick={() => act("ticket-clear", { self_ref: self_ref })}
        />
        <Button
          content="Select Ticket - Open"
          disabled={!holderActive}
          color="blue"
          onClick={() => act("ticket-select", { self_ref: self_ref })}
        />
        <Button
          content="Select Ticket - All"
          disabled={!holderActive}
          color="blue"
          onClick={() => act("ticket-select-all", { self_ref: self_ref })}
        />
      </>
    } />
  );
};

const TicketInformation = (props, context) => {
  const { data, act } = useBackend(context);
  const { mdata, self_ref } = data;
  const { ticketData, holderName } = mdata;
  const { creator, location, title, extra, handler } = ticketData;
  const { status, priority } = ticketData;

  return (
    <Section title={"Ticket Information / " + priority + " Priority"} buttons={
      <>
        <ButtonCheckbox
          content={handler === "None" ? "Handle" : handler}
          color="blue"
          checked={handler !== "None"}
          disabled={status !== "Open" || handler !== "None"}
          onClick={() => act("ticket-handle", { self_ref: self_ref })}
        />
        <ButtonCheckbox
          content="Resolve"
          color="good"
          checked={status === "Resolved"}
          disabled={handler !== holderName || status !== "Active"}
          onClick={() => act("ticket-resolve", { self_ref: self_ref })}
        />
        <ButtonCheckbox
          content="Reject"
          color="bad"
          checked={status === "Rejected"}
          disabled={handler !== holderName || status !== "Active"}
          onClick={() => act("ticket-reject", { self_ref: self_ref })}
        />
      </>
    }>
      <h1>{title}</h1>
      <br />
      <h2>Creator - {creator}</h2>
      <br />
      <h2>Location - {location}</h2>
      <br />
      <h3>Additional Details:</h3>
      <p>{extra}</p>
    </Section>
  );
};

const TicketImage = (props, context) => {
  const { data, act } = useBackend(context);
  const { self_ref } = data;
  return (
    <Section title="Attached Image" buttons={
      <Button
        content="View Image"
        onClick={() => act("image-view-holder", { self_ref: self_ref })}
        color="blue" />
    } />
  );
};
