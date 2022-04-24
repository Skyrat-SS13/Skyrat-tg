import { useBackend } from '../backend';
import { Stack, Icon, Box } from '../components';
import { Window } from '../layouts';
import { Component } from 'inferno';
import { shallowDiffers } from '../../common/react';

export class Map extends Component {
  constructor() {
    super();
    this.state = {
      selectedName: null,

      lastClientX: 0,
      lastClientY: 0,
      mapX: 0,
      mapY: 0,
    };

    this.handleMouseDown = this.handleMouseDown.bind(this);
    this.handleMouseUp = this.handleMouseUp.bind(this);
    this.handleMouseMove = this.handleMouseMove.bind(this);
  }

  handleMouseDown(event) {
    const { clientX, clientY } = event;
    this.setState({
      selectedName: null,
      lastClientX: clientX,
      lastClientY: clientY,
    });

    window.addEventListener('mouseup', this.handleMouseUp);
    window.addEventListener('mousemove', this.handleMouseMove);
  }

  handleMouseUp(event) {
    window.removeEventListener('mouseup', this.handleMouseUp);
    window.removeEventListener('mousemove', this.handleMouseMove);
  }

  handleMouseMove(event) {
    const { clientX, clientY } = event;

    this.setState(state => {
      return {
        mapX: state.mapX + clientX - state.lastClientX,
        mapY: state.mapY + clientY - state.lastClientY,
        lastClientX: clientX,
        lastClientY: clientY,
      };
    });
  }

  render() {
    const { data } = useBackend(this.context);
    const {
      map_name,
      map_size_x,
      map_size_y,
      coord_data,
      icon_size,
    } = data;
    const {
      mapX,
      mapY,
      selectedName,
    } = this.state;
    const {
      x,
      y,
    } = this.props;

    return (
      <Window
        width={600}
        height={600}
        theme="engi"
      >
        <Window.Content>
          <Stack justify="space-around">
            <Stack.Item>
              <Box
                className="Minimap__Map"
                style={{
                  'background-image': `url('minimap.${map_name}.png')`,
                  'background-repeat': "no-repeat",
                  'width': `${map_size_x}px`,
                  'height': `${map_size_y}px`,
                  'transform': `translate(${x || mapX}px, ${y || mapY}px)`,
                }}
                position="absolute"
                onMouseDown={this.handleMouseDown}
              >
                {coord_data.map(val => {
                  return (
                    <Object
                      key={val.ref}
                      name={val.name}
                      opacity={!selectedName
                        || selectedName === val.ref? 1 : 0.5}
                      selected={selectedName === val.ref}
                      coord={[
                        val.coord[0]*icon_size,
                        (map_size_y/icon_size-val.coord[1])*icon_size,
                      ]}
                      onMouseDown={e => {
                        this.setState({ selectedName: val.ref });
                        e.stopPropagation();
                      }}
                      icon={val.icon}
                      color={val.color}
                      obj_ref={val.ref}
                      obj_width={val.width}
                      obj_height={val.height}
                    />
                  );
                })}
              </Box>
            </Stack.Item>
          </Stack>
        </Window.Content>
      </Window>
    );
  }
}

export class Object extends Component {
  constructor() {
    super();
  }

  shouldComponentUpdate(nextProps, nextState) {
    return shallowDiffers(nextProps, this.props)
      || shallowDiffers(nextState, this.state);
  }

  render() {
    const { data } = useBackend(this.context);
    const { icon_size } = data;
    const {
      name,
      coord,
      icon,
      color,
      obj_ref,
      obj_width,
      obj_height,
      selected,
      ...rest
    } = this.props;

    return (
      <Box
        className="Minimap__Player"
        width="10%"
        {...rest}
        position="absolute"
        left={`${coord[0]-icon_size}px`}
        top={`${coord[1]-((obj_height-1)*icon_size)}px`}
      >
        <Stack vertical fill>
          <Stack.Item>
            <Box
              as="span"
              className="Minimap__Player_Icon"
              position="absolute"
              backgroundColor={color}
              width={`${icon_size*obj_width}px`}
              height={`${icon_size*obj_height}px`}
            />
          </Stack.Item>
          <Stack.Item
            className="Minimap__InfoBox"
            ml={selected === obj_ref
              ? `${icon_size*obj_width}px`
              : `${(icon_size*obj_width)/2}px`}
            mt={selected === obj_ref
              ? `${icon_size*obj_height}px`
              : `${(obj_height-1)*icon_size}px`}>
            <Box
              position="absolute"
              px={1}
              py={1}
              className={`Minimap__InfoBox${
                selected === obj_ref? "--detailed" : ""}`}
            >
              <Stack>
                {selected === obj_ref && (
                  <Stack.Item>
                    <Icon name={icon} />
                  </Stack.Item>
                )}
                <Stack.Item>
                  {name}
                </Stack.Item>
              </Stack>
            </Box>
          </Stack.Item>
        </Stack>
      </Box>
    );
  }
}
