# RabbitMQ connection

## Spring
### Artifact 
org.springframework.boot:spring-boot-starter-amqp

### Queue creation
Creating queue bound to default exchange:
    @Bean
    public Queue hello() {
        return new Queue("hello");
    }

### Properties
No props needed if default username:password (guest:guest).
Otherwise:
spring:
  rabbitmq:
    username: user
    password: password

### Send message:
Sending message:
    private final RabbitTemplate template;
    private final Queue queue;


    public void send() {
        String message = "Hello World!";
        this.template.convertAndSend(queue.getName(), message);
        System.out.println(" [x] Sent '" + message + "'");
    }

