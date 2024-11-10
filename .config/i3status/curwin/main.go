package main

import (
	"bufio"
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

type dtype map[string]string

func get_window_id() (string, error) {
	cmd := exec.Command("xprop", "-root")
	stdout, err := cmd.Output()
	if err != nil {
		return "", errors.New("unable to parse xprop root")
	}

	out := strings.Split(string(stdout), "\n")
	for _, s := range out {
		if strings.HasPrefix(s, "_NET_ACTIVE_WINDOW(WINDOW)") {
			split := strings.Split(s, " ")
			return strings.TrimSpace(split[len(split)-1]), nil
		}
	}
	return "", errors.New("not able to find window id")
}

func get_window_name() (string, error) {
	window_id, err := get_window_id()
	if err != nil {
		return "", err
	}

	cmd := exec.Command("xprop", "-id", window_id)
	stdout, err := cmd.Output()
	if err != nil {
		return "", errors.New("unable to parse xprop id for window")
	}
	out := strings.Split(string(stdout), "\n")
	for _, s := range out {
		if strings.HasPrefix(s, "_NET_WM_NAME") {
			split := strings.Split(s, "=")
			return strings.ReplaceAll(strings.TrimSpace(split[len(split)-1]), `"`, ""), nil
		}
	}
	return "", errors.New("not able to window name")
}

func encode(payload []any) (string, error) {
	buffer := &bytes.Buffer{}
	encoder := json.NewEncoder(buffer)
	encoder.SetEscapeHTML(false)
	err := encoder.Encode(payload)
	return buffer.String(), err
}

func main() {

	reader := bufio.NewReader(os.Stdin)
	lineBytes, _, err := reader.ReadLine()
	if err != nil {
		os.Exit(3)
	}
	fmt.Println(string(lineBytes))
	lineBytes, _, err = reader.ReadLine()
	if err != nil {
		os.Exit(3)
	}
	fmt.Println(string(lineBytes))

	for {
		lineBytes, _, err := reader.ReadLine()
		line := string(lineBytes)
		prefix := ""
		if strings.HasPrefix(line, ",") {
			line, prefix = line[1:], ","
		}
		_ = prefix
		if err != nil {
			os.Exit(3)
		}

		var payload []interface{}
		err = json.Unmarshal([]byte(line), &payload)
		if err != nil {
			fmt.Println(err)
			os.Exit(3)
		}

		window_name, err := get_window_name()
		if err != nil {
			window_name = ""
		}

		color := "#458588"
		data := map[string]any{
			"full_text":             fmt.Sprintf("<span weight='bold' foreground='%s'>%s</span>", color, window_name),
			"name":                  "window name",
			"markup":                "pango",
			"separator":             false,
			"separator_block_width": 10,
		}
		padding := map[string]any{
			"full_text":             " ",
			"name":                  "p",
			"markup":                "pango",
			"separator":             true,
			"separator_block_width": 2,
		}
		payload = append([]any{data, padding}, payload...)

		out, err := encode(payload)
		if err != nil {
			os.Exit(3)
		}
		fmt.Printf("%s%s", prefix, out)
	}

}
