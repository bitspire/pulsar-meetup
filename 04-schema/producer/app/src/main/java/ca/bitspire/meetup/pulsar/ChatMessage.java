package ca.bitspire.meetup.pulsar;

public class ChatMessage {

    private String from;
    private String message;
    private long timestamp;

    public ChatMessage(String from, String message) {
        this.from = from;
        this.message = message;
        this.timestamp = System.currentTimeMillis();
    }

    public String getFrom() {
        return from;
    }
    public String getMessage() {
        return message;
    }
    public long getTimestamp() {
        return timestamp;
    }
}