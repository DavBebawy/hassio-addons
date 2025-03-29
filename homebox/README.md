# Home Assistant Add-on: HomeBox

![Version](https://img.shields.io/badge/dynamic/json?label=Version&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavbebawy%2Fhassio-addons%2Fmain%2Fhomebox%2Fconfig.json)
![Ingress](https://img.shields.io/badge/dynamic/json?label=Ingress&query=%24.ingress&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavbebawy%2Fhassio-addons%2Fmain%2Fhomebox%2Fconfig.json)
![Arch](https://img.shields.io/badge/dynamic/json?color=success&label=Arch&query=%24.arch&url=https%3A%2F%2Fraw.githubusercontent.com%2Fdavbebawy%2Fhassio-addons%2Fmain%2Fhomebox%2Fconfig.json)

## About

![HomeBox Logo](https://raw.githubusercontent.com/sysadminsmedia/homebox/main/docs/public/lilbox.svg)

HomeBox is the inventory and organization system built for the Home User! With a focus on simplicity and ease of use, Homebox is the perfect solution for your home inventory, organization, and management needs.

This add-on is based on the [HomeBox](https://github.com/sysadminsmedia/homebox) project and comes with key features:

- **Simple** - Designed to be simple and easy to use with minimal setup requirements
- **Fast** - Written in Go, extremely fast and requires minimal resources
- **Portable** - Uses SQLite and an embedded Web UI for easy deployment, use, and backup

## Screenshots

![HomeBox Screenshot](https://raw.githubusercontent.com/sysadminsmedia/homebox/main/docs/public/screenshot.png)

## Installation

The installation of this add-on is pretty straightforward and not different in
comparison to installing any other Home Assistant add-on.

1. [Add this repository][repository] to your Home Assistant instance.
2. Install the "HomeBox" add-on.
3. Click the `Save` button to store your configuration.
4. Start the add-on.
5. Check the logs of the add-on to see if everything went well.
6. Click the "OPEN WEB UI" button to open the HomeBox interface.

## Configuration

```yaml
ssl: false
certfile: fullchain.pem
keyfile: privkey.pem
localdisks: ''
networkdisks: ''
cifsusername: ''
cifspassword: ''
cifsdomain: ''
```

### Option: `ssl`

Enables/Disables SSL (HTTPS) on the web interface. Set it to `true` to enable it, `false` otherwise.

### Option: `certfile`

The certificate file to use for SSL.

**Note**: _The file MUST be stored in `/ssl/`, which is the default_

### Option: `keyfile`

The private key file to use for SSL.

**Note**: _The file MUST be stored in `/ssl/`, which is the default_

### Option: `localdisks`

This option allows you to mount local disks in the HomeBox container.

Usage example: `/dev/sda1=/mnt/sda1`

### Option: `networkdisks`

This option allows you to mount network shares in the HomeBox container.

Usage example: `//SERVER/SHARE=/mnt/share`

### Option: `cifsusername`/`cifspassword`/`cifsdomain`

If you use network disks, you might need to specify your credentials.

## Using HomeBox

After the add-on is started, the interface will be available at the
"OPEN WEB UI" button.

1. Open the HomeBox interface
2. The default credentials are:
   - Username: `admin@example.com`
   - Password: `admin`
3. Begin by creating locations, items, and organizing your inventory

## Support

Got questions?

- [Open an issue on our GitHub Repository][issues]
- [Check the official HomeBox documentation][homebox-docs]

[repository]: https://github.com/davbebawy/hassio-addons
[issues]: https://github.com/davbebawy/hassio-addons/issues
[homebox-docs]: https://homebox.software/en/ 