import { ByondUi } from "../../components";


export const CharacterPreview = (props: {
  width?: string,
  height: string,
  id: string,
}) => {
  const {
    width = '220px',
  } = props;
  return (<ByondUi
    width={width}
    height={props.height}
    params={{
      id: props.id,
      type: "map",
    }}
  />);
};
