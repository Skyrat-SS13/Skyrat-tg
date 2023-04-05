import { ByondUi } from '../../components';

export const CharacterPreview = (props: {
  width?: string; // SKYRAT EDIT
  height: string;
  id: string;
}) => {
  // SKYRAT EDIT
  const { width = '220px' } = props;
  // SKYRAT EDIT END
  return (
    <ByondUi
      width={width} // SKYRAT EDIT
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
